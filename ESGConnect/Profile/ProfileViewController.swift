//
//  ProfileViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 13.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {

//MARK: Setup
    
    
    
    //MARK: Table Setup
    lazy var SettingsTable: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifer)
        return tb
    }()
    var items = ["Personal Info", "Frequently Asked Questions", "Log Out"]

    //MARK: Auth Setup
    weak var handle: AuthStateDidChangeListenerHandle?
    
    
    
//MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBlue")
    
        //MARK: Settings Table Set
        self.setView()
        SettingsTable.backgroundColor = UIColor(named: "AppBlue")
        self.view.addSubview(self.SettingsTable)
        self.setTableLayout()
        self.getUserData()
    }
    
    
//MARK: Hi Text Function
    var hiText = UILabel()
    func setView(){
        hiText.text = ""
        hiText.font = hiText.font.withSize(30)
        hiText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hiText)

        NSLayoutConstraint.activate([
            hiText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            hiText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            ])
    }
    
    
    
//MARK: Table Layout
    func setTableLayout(){
        SettingsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            SettingsTable.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            SettingsTable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -10),
            SettingsTable.widthAnchor.constraint(equalToConstant: 300),
            SettingsTable.heightAnchor.constraint(equalToConstant: 300)
            ])
    }
    
    
    
//MARK: Log Out
    func logOut(){
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
    
    
    
//MARK: Color Text Beginning
    func addSpecificColorText(fullString: NSString, colorPartOfString: NSString) -> NSAttributedString {
        let nonColorFontAttribute = [NSAttributedString.Key.foregroundColor: UIColor(named: "AppYellow")]
        let colorFontAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let coloredString = NSMutableAttributedString(string: fullString as String, attributes:nonColorFontAttribute as [NSAttributedString.Key : Any])
        coloredString.addAttributes(colorFontAttribute, range: fullString.range(of: colorPartOfString as String))
        return coloredString
    }
}

//MARK: Table Extension
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: Rov Number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //MARK: Cell Content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifer, for: indexPath) as! SettingsTableViewCell
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.numberOfLines = -1
        cell.textLabel?.textColor = .white
        return cell
    }
    
    //MARK: Cell Select Function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            tableView.deselectRow(at: indexPath, animated: true)
            self.navigationController?.pushViewController(PersonalInfoViewController(), animated: true)
        }
        if (indexPath.row == 1) {
            tableView.deselectRow(at: indexPath, animated: true)
            self.navigationController?.pushViewController(FAQViewController(), animated: true)
        }
        if (indexPath.row == 2) {
            tableView.deselectRow(at: indexPath, animated: true)
            logOut()
        }
    }
    
    
    
    //MARK: Get User Data
    func getUserData(){
        let db = Firestore.firestore()
        let user = (Auth.auth().currentUser?.uid)!
        db.collection("users").document(user).addSnapshotListener { documentSnapshot, error in
          guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
          }
          guard let data = document.data()?["name"] else {
            print("Document data was empty.")
            return
          }
            self.hiText.text = ("Hi, " + (data as? String ?? ""))
            self.hiText.attributedText = self.addSpecificColorText(fullString: self.hiText.text! as NSString, colorPartOfString: "Hi, ")
        }
    }
}
