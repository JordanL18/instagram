//
//  ProfileExtension.swift
//  Instagram
//
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @objc func takePhoto() {
        
        singlePhoto = false
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        
        var selectedImage: UIImage?
        
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] {
            selectedImage = editedImage as? UIImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImage = originalImage as? UIImage
            
        }
        
        let imageName = NSUUID().uuidString
        let bigRoot = HashDescrWindow();

        if let selected = selectedImage {
            image = selected
            let storage = Storage.storage().reference().child(imageName)
            let uploadData = UIImagePNGRepresentation(selected)
            storage.putData(uploadData!, metadata: nil, completion: {(metadata, error) in
                if(self.singlePhoto == true) {
                    let toPut = ref.child("users").child(userID!).child("userPhoto");
                    toPut.setValue(metadata?.downloadURL()?.absoluteString)
                    self.singlePhoto = false
                    self.viewDidLoad()
                }
                else {
                    
                    
                    let toPhotos = ref.child("photos").childByAutoId()
                    
                    let timestamp = NSDate().timeIntervalSince1970
                    
                    toPhotos.child("timestamp").setValue(timestamp)
                    
                    
                    toPhotos.child("photo").setValue(metadata?.downloadURL()?.absoluteString)
                    toPhotos.child("count").setValue(0)
                    toPhotos.child("likedBy").setValue("")
                    toPhotos.child("name").setValue(userID)

                    
                    bigRoot.second = toPhotos

                    
                    let toPut = ref.child("users").child(userID!).child("Photos").childByAutoId()
                    bigRoot.id = toPut
                    
                    
                    
                    
                    toPut.child("photo").setValue(metadata?.downloadURL()?.absoluteString)
                    let toPut2 = ref.child("likes").childByAutoId()
                    toPut2.child("count").setValue(0)
                    toPut2.child("likedBy").setValue("")
                    
                    bigRoot.imageURL = (metadata?.downloadURL()?.absoluteString)!
                    
                }})
        }
        dismiss(animated: false, completion: nil)
        if(self.singlePhoto == false) {
            
            bigRoot.photo = selectedImage!
            bigRoot.dan = self
            let nav =  UINavigationController(rootViewController: bigRoot)
            
            present(nav, animated: true, completion: nil)
        }

        
        
    }
    
    func populateWithUrl(){
        
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        
        ref.child("users").child(userID!).child("Photos").observeSingleEvent(of: .value, with: {(snapshot) in
            for child in snapshot.children {
                let child1 = child as? DataSnapshot
                let photos = child1?.value as? NSDictionary
                
                
                let photosUrl = photos?.value(forKey: "photo") as? String
                
                self.photosArray.insert(photosUrl!, at: 0)
                
                
              self.collectionView?.reloadData()
            }}
            
        )
        
        
    }
    
    @objc func profileImageTapped(gestureRecognizer: UITapGestureRecognizer) {
        singlePhoto = true;
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        
        present(picker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
