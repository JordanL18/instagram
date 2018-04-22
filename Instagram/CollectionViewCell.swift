//
//  CollectionViewCell.swift
//  Instagram
//
//

import UIKit

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import SystemConfiguration

class HashDescrWindow: UIViewController, UITextViewDelegate {
    
    
    
    var dan = ProfileViewController()
    
    var id = DatabaseReference()
    
    var second = DatabaseReference()
    
    var photo = UIImage()
    
    var descrBox = UITextView()
    let ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    
    var imageURL = String()
    var refreshControla: UIRefreshControl!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descrBox.delegate = self
        descrBox.textColor = UIColor.lightGray
        descrBox.text = "Description"
        
     
        
        
        
        setupUI();
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func setupUI() {
        
   
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Description"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(goBack))
        
        let imageView = UIImageView(image: photo)
        view.addSubview(imageView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20
            
            ).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let uiText = UITextView()
        uiText.text = "Add Description"
        uiText.font = uiText.font?.withSize(30)
        uiText.textColor = UIColor.purple
        uiText.textAlignment = .center
        uiText.isEditable = false
        view.addSubview(uiText)
        uiText.translatesAutoresizingMaskIntoConstraints = false
        uiText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uiText.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        uiText.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        uiText.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1.0)/(12)).isActive = true
        uiText.backgroundColor = UIColor.clear
        
        view.addSubview(descrBox)
        descrBox.translatesAutoresizingMaskIntoConstraints = false
        descrBox.backgroundColor = UIColor.white
        descrBox.topAnchor.constraint(equalTo: uiText.bottomAnchor).isActive = true
        descrBox.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        descrBox.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1.0)/(5.0)).isActive = true
        
        
        
        
        
        
        
        
    }
    
    @objc func goBack() {
        
        
       let yep = second.child("Description")
        yep.setValue(descrBox.text)
        
        let def = id.child("Description")
        def.setValue(descrBox.text)
        dan.photosArray = []
        
        dan.populateWithUrl()
        self.dismiss(animated: true, completion: nil)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}
