//
//  CredentialsViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 17.07.2023.
//

//MARK: Import
import UIKit
import FirebaseAuth

class CredentialsViewController: UIViewController {
    
//MARK: Set Up
    
    
    
    //MARK: Set Variables
    var signupButton = UIButton()
    var loginButton = UIButton()
    
    
//MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBlue")
        
        //MARK: Check User Logged In Status
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
               self.navigationController?.pushViewController(TabBarViewController(), animated: true)
               self.navigationController?.setNavigationBarHidden(true, animated: true)
           } else {
           }
        }
        
        //MARK: Set Labels
        self.setLabels()
    }
    
    
    
//MARK: Set Up Layout
    func setLabels(){
        
        
        //MARK: Image Features
        let imageLogo = UIImage(named: "Logo")
        let imageView = UIImageView(image: imageLogo)
        imageView.clipsToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: No Account Button Features
        signupButton.backgroundColor = UIColor(named: "AppYellow")
        signupButton.setTitle("Create Account", for: .normal)
        signupButton.tintColor = .white
        signupButton.layer.cornerRadius = 5
        signupButton.clipsToBounds = true
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(transitiontoSignUp), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Login Button Features
        loginButton.backgroundColor = UIColor(named: "AppYellow")
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(transitiontoLogIn), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        

        
        //MARK: Varibles Constraints
        NSLayoutConstraint.activate([
            
            
            //MARK: Image Constraints
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            
            //MARK: No Account Button Constraints
            signupButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signupButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 35),
            
            //MARK: Login Button Constraints
            loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -10),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    
    
//MARK: Transition to Log In
    @objc func transitiontoLogIn(){
        self.navigationController?.pushViewController(LogInViewController(), animated: true)
    }
    
    
    
//MARK: Transition to Sign Up
    @objc func transitiontoSignUp(){
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}
