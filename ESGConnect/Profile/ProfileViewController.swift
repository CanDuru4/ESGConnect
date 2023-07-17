//
//  ProfileViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 13.07.2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    var logoutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        logoutButton.backgroundColor = UIColor(named: "AppYellow")
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.tintColor = .white
        logoutButton.layer.cornerRadius = 15
        logoutButton.clipsToBounds = true
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            logoutButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    
    //MARK: Log Out
    @objc func logOut(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        self.tabBarController?.tabBar.isHidden = true
        let newViewControllers = NSMutableArray()
        newViewControllers.add(CredentialsViewController())
        self.navigationController?.setViewControllers(newViewControllers as! [UIViewController], animated: true)
    }

}
