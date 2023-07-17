//
//  SignUpViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 13.07.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpViewController: UIViewController {

    //MARK: Set Up
        
        
        
        //MARK: Set Variables
        var nameField = UITextField()
        var emailField = UITextField()
        var passwordField = UITextField()
        var passwordAuthenticateField = UITextField()
        var signUpButton = UIButton()
        

        
    //MARK: Load
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(named: "AppBlue")
            setLabels()
            
            //MARK: Hide Keyboard
            self.hideKeyboardWhenTappedAround()
        }
        

        
    //MARK: Variables Features
        func setLabels(){
            
            
            //MARK: Image Feature
            let imageLogo = UIImage(named: "ESGLogo")
            let imageView = UIImageView(image: imageLogo)
            imageView.clipsToBounds = true
            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false

            //MARK: Name Field Feature
            nameField.placeholder = "Name"
            nameField.borderStyle = .roundedRect
            nameField.layer.borderColor = CGColor(red: 255/255, green: 191/255, blue: 69/255, alpha: 1)
            nameField.layer.borderWidth = CGFloat(1)
            nameField.autocorrectionType = .no
            view.addSubview(nameField)
            nameField.translatesAutoresizingMaskIntoConstraints = false
            
            //MARK: Email Field Feature
            emailField.placeholder = "Email"
            emailField.borderStyle = .roundedRect
            emailField.layer.borderColor = CGColor(red: 255/255, green: 191/255, blue: 69/255, alpha: 1)
            emailField.layer.borderWidth = CGFloat(1)
            emailField.autocorrectionType = .no
            emailField.autocapitalizationType = .none
            view.addSubview(emailField)
            emailField.translatesAutoresizingMaskIntoConstraints = false

            //MARK: Password Field Feature
            passwordField.placeholder = "Password"
            passwordField.borderStyle = .roundedRect
            passwordField.layer.borderColor = CGColor(red: 255/255, green: 191/255, blue: 69/255, alpha: 1)
            passwordField.layer.borderWidth = CGFloat(1)
            view.addSubview(passwordField)
            passwordField.isSecureTextEntry = true
            passwordField.autocorrectionType = .no
            emailField.autocapitalizationType = .none
            passwordField.translatesAutoresizingMaskIntoConstraints = false
            
            //MARK: Password Authenticate Field Feature
            passwordAuthenticateField.placeholder = "Authenticate Password"
            passwordAuthenticateField.borderStyle = .roundedRect
            passwordAuthenticateField.layer.borderColor = CGColor(red: 255/255, green: 191/255, blue: 69/255, alpha: 1)
            passwordAuthenticateField.layer.borderWidth = CGFloat(1)
            view.addSubview(passwordAuthenticateField)
            passwordAuthenticateField.isSecureTextEntry = true
            passwordAuthenticateField.autocorrectionType = .no
            emailField.autocapitalizationType = .none
            passwordAuthenticateField.translatesAutoresizingMaskIntoConstraints = false

            //MARK: Sign Up Button Feature
            signUpButton.backgroundColor = UIColor(named: "AppYellow")
            signUpButton.setTitle("Sign Up", for: .normal)
            signUpButton.tintColor = .white
            signUpButton.layer.cornerRadius = 15
            signUpButton.clipsToBounds = true
            view.addSubview(signUpButton)
            signUpButton.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
            signUpButton.translatesAutoresizingMaskIntoConstraints = false
            
            
            
            //MARK: Constraints
            NSLayoutConstraint.activate([
                
                
                //MARK: Image Constraints
                imageView.centerXAnchor.constraint(equalTo: nameField.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
                imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
                imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
                
                //MARK: Name Field Constraints
                nameField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                nameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
                nameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                nameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                nameField.heightAnchor.constraint(equalToConstant: 35),

                
                //MARK: Email Field Constraints
                emailField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 5),
                emailField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                emailField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                emailField.heightAnchor.constraint(equalToConstant: 35),

                
                //MARK: Password Field Constraints
                passwordField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 5),
                passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                passwordField.heightAnchor.constraint(equalToConstant: 35),

                
                //MARK: Password Authenticate Field Constraints
                passwordAuthenticateField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                passwordAuthenticateField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 5),
                passwordAuthenticateField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                passwordAuthenticateField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                passwordAuthenticateField.heightAnchor.constraint(equalToConstant: 35),

                
                //MARK: Sign Up Button Constraints
                signUpButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                signUpButton.topAnchor.constraint(equalTo: passwordAuthenticateField.bottomAnchor, constant: 10),
                signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
                signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
                signUpButton.heightAnchor.constraint(equalToConstant: 35),
            ])
        }
        

        
    //MARK: Sign Up Button Action
        @objc func signUpUser(){
            
            
            //MARK: Validate All Fields
            let error = validateFields()
            
            if error != nil {

            } else {
                //MARK: All Fields Filled
                let name = nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                //MARK: Create User
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    if  err != nil{
                        let alert = UIAlertController(title: "An error occured. Try again.", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        let db = Firestore.firestore()
                        db.collection("users").addDocument(data: ["name":name, "uid": result!.user.uid]) { (error) in
                            if error != nil {
                                let alert = UIAlertController(title: "An error occured. Try again.", message: "", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "user_uid_key")
                        UserDefaults.standard.synchronize()
                        Auth.auth().currentUser?.sendEmailVerification { error in
                        }
                        self.dismiss(animated: true)
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                        self.navigationController?.setNavigationBarHidden(true, animated: true)
                    }
                }
            }
        }
        
        
        
    //MARK: Validate Fields
        func validateFields() -> String? {
            
            
            //MARK: Check Empty Fields
            if nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordAuthenticateField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                let alert = UIAlertController(title: "Please fill the all fields.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return "Lütfen bütün boşlukları doldurun."
            }
            
            //MARK: Check Match Between Passwords
            let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let authenticatecleanedPassword = passwordAuthenticateField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if cleanedPassword != authenticatecleanedPassword{
                let alert = UIAlertController(title: "Passwords do not match.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return "Doğrulama şifreniz ile girdiğiniz şifre uyuşmuyor. "

            }
            
            //MARK: Validate Password
            if isPasswordValid(cleanedPassword) == false {
                let alert = UIAlertController(title: "Passwords should contain special characters and be at least 8 characters.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return "Lütfen şifrenizin en az 8 karakter olduğundan, özel bir karakter (!,?,&,...) ve bir sayı içerdiğinden emin olun."
            }
            return nil
        }
        
        
        
    //MARK: Password Requirements
        func isPasswordValid(_ password : String) -> Bool {
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: password)
        }
}

//MARK: Hide Keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
