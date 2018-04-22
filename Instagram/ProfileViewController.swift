//
//  ProfileViewController.swift
//  Instagram
//
//

import UIKit
import FirebaseDatabase
import Firebase


class ProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
 
    
    let reference = Database.database().reference()
    let ID = Auth.auth().currentUser?.uid
    var photosArray = [String]()
    var image = UIImage()
    var singlePhoto = false
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photosArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! profilePageImagesCollectionViewCell
        
        cell.imageUrla = photosArray[indexPath.row]
        
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white
       
        
        collectionView?.register(profilePageImagesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

    
        navigationController?.navigationBar.topItem?.title = "Instagram"
        setupUI()
        photosArray = []
        populateWithUrl()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    func setupUI() {
        
        
        let headerSize = navigationController?.navigationBar.frame.height ?? 0
        let profileImageWidth = CGFloat(100)
        
        
        view.backgroundColor = .white
        
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = profileImageWidth/2
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.clipsToBounds = true

        profileImage.isUserInteractionEnabled = true
        
        let recogn = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(recogn)
        
        view.addSubview(profileImage)
        
        print(headerSize)
        [
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: headerSize+25),
        profileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        profileImage.widthAnchor.constraint(equalToConstant: profileImageWidth),
        profileImage.heightAnchor.constraint(equalToConstant: profileImageWidth*2/2)
        
        
        ].forEach({$0.isActive = true })
        
        
        
        
        //Download image
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        
        reference.child("users").child(ID!).observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.hasChild("userPhoto") {
                self.reference.child("users").child(self.ID!).child("userPhoto").observeSingleEvent(of: .value, with: {(snap) in
                    let url = URL(string: snap.value as! String);
                    
                    var sessionA = URLSession(configuration: .default)
                    let download = sessionA.dataTask(with: url!) { (data, response, error) in
                        if let e = error {
                            print("Error downloading photo: \(e)")
                        }else{
                            if (response as? HTTPURLResponse) != nil {
                                if let imageData = data {
                                    let image = UIImage(data: imageData)
                                    DispatchQueue.main.async {
                                  profileImage.image = image
                                   
                                    }
                                } else {
                                    print("Couldn't get image: Image is nil")
                                }
                            } else {
                                print("Couldn't get response code for some reason")
                            }
                        }
                        
                    }
                    download.resume()
                    
                }
                    
                )}
        })
        
        
        
        
        
        
        
        
        setupLayout()
        collectionView?.anchor(top: profileImage.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left:0, bottom: 0, right: 0))
        
      
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera-7"), style: .plain, target: self, action: #selector(takePhoto))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        
        
        
        
        
    }
    
    func setupLayout() {
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 3
        let interItemSpacingTotal = layout.minimumLineSpacing*(cellsPerLine-1)
        let width = view.frame.width/cellsPerLine - interItemSpacingTotal/cellsPerLine
        layout.itemSize = CGSize(width: width, height:  width*2/2)
        
    }
    
    
   @objc func signOut() {
  try!  Auth.auth().signOut()
    self.present(LoginViewController(), animated: true, completion: nil)
    
    
        
    }
    
    

 

}

