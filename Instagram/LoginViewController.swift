//
//  LoginViewController.swift
//  Instagram
//
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {


    var ref: DatabaseReference!


    let login = UITextField()
    let password = UITextField()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        setupUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
    
    
    
    @objc func logMeIn() {
        
        let user = login.text ?? ""
        let pass = password.text ?? ""
        
        Auth.auth().signIn(withEmail: user, password: pass) {
            (user, error ) in
            if(error != nil) {
                print(error)
                let alertController = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                }
                alertController.addAction(OKAction)
                self.present(alertController , animated: true,completion: nil)
                
            }
            else {
                
                self.present(CustomTabBar(), animated: true, completion: nil)
            }
            
        }
        
        
    
    
    }
    
    
    
    
    
    
    @objc func signUP() {
        
        
        let email = login.text ?? ""
        let pass = password.text ?? ""
        
        
    
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
        
            if error != nil {
                
                let alertController = UIAlertController(title: "Error", message: "Oops, something went wrong", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                }
                alertController.addAction(OKAction)
                self.present(alertController , animated: true,completion: nil)

            }
            else {
                
                if let current = user {
                self.ref.child("users").child(current.uid).setValue(["username": email])
                }
                
                let alertController = UIAlertController(title: "Success", message: "User has been created", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                }
                alertController.addAction(OKAction)
                self.present(alertController , animated: true,completion: nil)

            }
        
        }
        
    }
    
    
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        var image = UIImageView(image: #imageLiteral(resourceName: "Icon-60"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image)
        
        [     image.widthAnchor.constraint(equalToConstant: 90),
        image.heightAnchor.constraint(equalToConstant: 100),
        image.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ].forEach({$0.isActive = true})
        
        
        login.translatesAutoresizingMaskIntoConstraints = false
        login.autocorrectionType = .no
        login.placeholder = "Login"
        login.layer.cornerRadius = 3
        login.autocapitalizationType = .none
        login.backgroundColor = UIColor.white
        login.layer.borderWidth = 3
        login.textAlignment = .center
        
        view.addSubview(login)
        
        [login.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 1/2),
         login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         login.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         login.heightAnchor.constraint(equalToConstant: 40)
         
        
            ].forEach({$0.isActive = true })
        
        
        
        password.translatesAutoresizingMaskIntoConstraints = false
        password.autocorrectionType = .no
        password.placeholder = "Password"
        password.layer.cornerRadius = 3
        password.autocapitalizationType = .none
        password.backgroundColor = .white
        password.layer.borderWidth = 3
        password.isSecureTextEntry = true
        view.addSubview(password)
        password.textAlignment = .center
        
        
        [password.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
         password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 10),
         password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         password.heightAnchor.constraint(equalToConstant: 40)
        
            ].forEach({$0.isActive = true})
        
        
        
        let loginButton = UIButton()
        view.addSubview(loginButton)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = UIColor(displayP3Red: 122/255, green: 103/250, blue: 238/250, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        
        [
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
    
        
        
        
        ].forEach({$0.isActive = true
        })
        
        
        loginButton.addTarget(self, action: #selector(logMeIn), for: UIControlEvents.touchUpInside)
        
        
        let signupButton = UIButton()
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.backgroundColor = UIColor(displayP3Red: 122/255, green: 103/250, blue: 238/250, alpha: 1)
        signupButton.setTitle("Sign Up", for: .normal)
        
        
        view.addSubview(signupButton)
        
        [
        signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
        
        
        ].forEach({$0.isActive = true})
        signupButton.addTarget(self, action: #selector(signUP), for: .touchUpInside)
        
        
        
        
        
    }
    
    
    
    
}
