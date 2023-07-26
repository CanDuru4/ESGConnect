//
//  ViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 7.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import FirebaseDatabase

//MARK: Employee Array
struct Info {
    var name: String
    var location: String
    var education_employeeStatus: String
    var social: String
    var userinfo: String
}

class HomeViewController: UIViewController, UISearchBarDelegate {
    
//MARK: Set Up
    
    
    
    //MARK: Variable Set Up
    var listarray:[Info] = []{
        didSet{
            filtered = listarray
            infoTable.reloadData()
        }
    }
    var name: String!
    var location: String!
    var education_employeeStatus: String!
    var social: String!
    var searchTextVar: String!
    var useruid = Auth.auth().currentUser?.uid
    var userprofile: String!
    var userinfo: String!
    var searchChoice = 0
    var byNameButton = UIButton()
    var byLocationButton = UIButton()

        
    //MARK: Company Set Up
    var filtered:[Info] = []{
        didSet{
            infoTable.reloadData()
        }
    }
    
    //MARK: Table Setup
    lazy var infoTable: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifer)
        return tb
    }()
    var selectedCellIndexPath: IndexPath?
    
    //MARK: Search Controller
    lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search a Name"
        search.searchBar.tintColor = UIColor(named: "AppYellow")
        search.searchBar.searchTextField.leftView?.tintColor = UIColor(named: "AppYellow")
        search.searchBar.sizeToFit()
        search.searchBar.searchBarStyle = .prominent
        search.searchBar.delegate = self
        return search
    }()
    
    
    
//MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBlue")
        
        infoTable.backgroundColor = UIColor(named: "AppBlue")
        infoTable.separatorColor = UIColor(named: "AppYellow")
        view.addSubview(infoTable)
        self.navigationItem.title = "The Workable"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.searchController = searchController
        self.searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search a Name", attributes: [NSAttributedString.Key.foregroundColor:UIColor(named: "AppYellow")!])
        searchController.searchBar.searchTextField.textColor = UIColor(named: "AppYellow")
        filtered = []
        listarray = []
        getUserData {
            self.setLayout()
            self.infoTable.reloadData()
            if self.userprofile == "employee" {
                self.listarray = self.listarray.filter { ($0.userinfo.lowercased().contains("company")) }
            } else if self.userprofile == "company" {
                self.listarray = self.listarray.filter { ($0.userinfo.lowercased().contains("employee")) }
            }
        }
        repeatgetUserData()
    }
    
    
    
//MARK: Set Layout
    func setLayout(){
        
        byNameButton.setTitle("Search by Name", for: .normal)
        byNameButton.setTitleColor(.white, for: .normal)
        byNameButton.backgroundColor = UIColor(named: "AppYellow")
        byNameButton.layer.cornerRadius = 5
        byNameButton.clipsToBounds = true
        byNameButton.addTarget(self, action: #selector(byNameButtonAction), for: .touchUpInside)
        view.addSubview(byNameButton)
        
        byNameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([byNameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), byNameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5), byNameButton.widthAnchor.constraint(equalToConstant: 160), byNameButton.heightAnchor.constraint(equalToConstant: 20)])
        
        byLocationButton.setTitle("Search by Location", for: .normal)
        byLocationButton.setTitleColor(.white, for: .normal)
        byLocationButton.backgroundColor = UIColor(named: "AppYellow")
        byLocationButton.layer.cornerRadius = 5
        byLocationButton.clipsToBounds = true
        byLocationButton.addTarget(self, action: #selector(byLocationButtonAction), for: .touchUpInside)
        view.addSubview(byLocationButton)
        
        byLocationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([byLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), byLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5), byLocationButton.widthAnchor.constraint(equalToConstant: 160), byLocationButton.heightAnchor.constraint(equalToConstant: 20)])
        
        let tabelLabel = UILabel()
        tabelLabel.textColor = UIColor(named: "AppColor2")
        if userprofile == "company" {
            tabelLabel.text = "Employees"
            
        } else if userprofile == "employee" {
            tabelLabel.text = "Companies"
        }
        tabelLabel.font = tabelLabel.font.withSize(40)
        tabelLabel.textColor = .white
        tabelLabel.textAlignment = .left
        tabelLabel.clipsToBounds = true
        view.addSubview(tabelLabel)
        tabelLabel.underline()
        
        tabelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tabelLabel.topAnchor.constraint(equalTo: byNameButton.bottomAnchor, constant: 5), tabelLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)])
        
        infoTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([infoTable.topAnchor.constraint(equalTo: tabelLabel.bottomAnchor, constant: 10), infoTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), infoTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), infoTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)])
    }

    @objc func byNameButtonAction(){
        if searchChoice == 0 {
            searchChoice = 1
            byNameButton.backgroundColor = UIColor(named: "AppBlueDarker")
            byLocationButton.backgroundColor = UIColor(named: "AppYellow")
        } else if searchChoice == 2 {
            searchChoice = 1
            byNameButton.backgroundColor = UIColor(named: "AppBlueDarker")
            byLocationButton.backgroundColor = UIColor(named: "AppYellow")
        } else {
            searchChoice = 0
            byNameButton.backgroundColor = UIColor(named: "AppYellow")
            byLocationButton.backgroundColor = UIColor(named: "AppYellow")
        }
    }
    
    @objc func byLocationButtonAction(){
        if searchChoice == 0 {
            searchChoice = 2
            byNameButton.backgroundColor = UIColor(named: "AppYellow")
            byLocationButton.backgroundColor = UIColor(named: "AppBlueDarker")
        } else if searchChoice == 2 {
            searchChoice = 2
            byNameButton.backgroundColor = UIColor(named: "AppYellow")
            byLocationButton.backgroundColor = UIColor(named: "AppBlueDarker")
        } else {
            searchChoice = 0
            byNameButton.backgroundColor = UIColor(named: "AppYellow")
            byLocationButton.backgroundColor = UIColor(named: "AppYellow")
        }
    }
    
//MARK: Search Bar
    func isSearchBarEmpty() -> Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if isSearchBarEmpty() {
            listarray = []
            if timer.isValid {
                
            } else {
                repeatgetUserData()
            }
        } else{
            timer.invalidate()
            searchTextVar = searchText
            if searchChoice == 1 {
                self.filtered = self.filtered.filter { ($0.name.lowercased().contains(searchText.lowercased())) }
            } else if searchChoice == 2 {
                self.filtered = self.filtered.filter { ($0.location.lowercased().contains(searchText.lowercased())) }
            } else {
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        listarray = []
        if timer.isValid {
            
        } else {
            repeatgetUserData()
        }
        searchChoice = 0
        byNameButton.backgroundColor = UIColor(named: "AppYellow")
        byLocationButton.backgroundColor = UIColor(named: "AppYellow")
    }
    
    var timer = Timer()
    func repeatgetUserData(){
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { _ in
            self.listarray = []
            self.getUserData {
                self.infoTable.reloadData()
                if self.userprofile == "employee" {
                    self.listarray = self.listarray.filter { ($0.userinfo.lowercased().contains("company")) }
                } else if self.userprofile == "company" {
                    self.listarray = self.listarray.filter { ($0.userinfo.lowercased().contains("employee")) }
                }
            }
        })
    }
    
//MARK: Get User Data
    func getUserData(completion: @escaping () -> ()){
        let db = Firestore.firestore()
        let docRef = db.collection("users")
        docRef.getDocuments { querySnapshot, err in
            if err != nil{
                
            } else {
                for document in querySnapshot!.documents {
                    guard let dataUser = document.data()["userprofile"] else {
                        print("Document data was empty.")
                        return
                    }
                    
                    if (document.data()["uid"] as? String == Auth.auth().currentUser?.uid) {
                        self.userprofile = (dataUser as! String)
                    }
                    
                    if dataUser as! String == "employee" {
                        guard let dataName = document.data()["name"] else {
                            print("Document data was empty.")
                            return
                        }
                        guard let dataEducation = document.data()["educationstatus"] else {
                            print("Document data was empty.")
                            return
                        }
                        guard let dataSocial = document.data()["social"] else {
                            print("Document data was empty.")
                            return
                        }
                        guard let dataLocation = document.data()["location"] else {
                            print("Document data was empty.")
                            return
                        }
                        
                        self.name = dataName as? String ?? ""
                        self.social = dataSocial as? String ?? ""
                        self.education_employeeStatus = dataEducation as? String ?? ""
                        self.location = dataLocation as? String ?? ""
                        self.userinfo = (dataUser as! String)
                        self.listarray.append(Info(name: self.name, location: self.location, education_employeeStatus: self.education_employeeStatus, social: self.social, userinfo: self.userinfo))
                    }
                    if dataUser as! String == "company" {
                        guard let dataName = document.data()["name"] else {
                            print("Document data was empty.")
                            return
                        }
                        guard let dataEducation = document.data()["employeenumber"] else {
                            print("Document data was empty.")
                            return
                        }
                        guard let dataSocial = document.data()["website"] else {
                            print("Document data was empty.")
                            return
                        }
                        guard let dataLocation = document.data()["location"] else {
                            print("Document data was empty.")
                            return
                        }
                        
                        self.name = dataName as? String ?? ""
                        self.social = dataSocial as? String ?? ""
                        self.education_employeeStatus = dataEducation as? String ?? ""
                        self.location = dataLocation as? String ?? ""
                        self.userinfo = (dataUser as! String)
                        self.listarray.append(Info(name: self.name, location: self.location, education_employeeStatus: self.education_employeeStatus, social: self.social, userinfo: self.userinfo))
                    }
                }
                completion()
            }
        }
    }
}




//MARK: TableView Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: Row Number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }

    
    //MARK: Cell Content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifer, for: indexPath) as! InfoTableViewCell
        cell.backgroundColor = UIColor(named: "AppBlue")
        cell.dataStructure = filtered[indexPath.row]
        let title_text = filtered[indexPath.row].name
        cell.titleLabel.font = cell.titleLabel.font.withSize(20)
        cell.titleLabel.textColor = UIColor(named: "AppYellow")
        let attributedString = NSMutableAttributedString(string: title_text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title_text.count))
        cell.titleLabel.attributedText = attributedString

        cell.detailLabel_location.text = "Location: \(String(filtered[indexPath.row].location))"
        cell.detailLabel_location.font = cell.titleLabel.font.withSize(15)
        cell.detailLabel_location.textColor = .white

        if (filtered[indexPath.row].userinfo) == "employee" {
            cell.detailLabel_employee_education.text = "Education: \(filtered[indexPath.row].education_employeeStatus)"
        } else if (filtered[indexPath.row].userinfo) == "company" {
            cell.detailLabel_employee_education.text = "Employee Number: \(filtered[indexPath.row].education_employeeStatus)"
        }
        cell.detailLabel_employee_education.font = cell.titleLabel.font.withSize(15)
        cell.detailLabel_employee_education.textColor = .white
        
        if (filtered[indexPath.row].userinfo) == "employee" {
            cell.detailLabel_social.text = "Social: \(String(filtered[indexPath.row].social))"
        } else if (filtered[indexPath.row].userinfo) == "company" {
            cell.detailLabel_social.text = "Website: \(String(filtered[indexPath.row].social))"
        }
        cell.detailLabel_social.font = cell.titleLabel.font.withSize(15)
        cell.detailLabel_social.textColor = .white
        return cell
    }

    //MARK: Table Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //MARK: Select Function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UILabel {
    func underline() {
        guard let tittleText = self.text else { return }
        let attributedString = NSMutableAttributedString(string: (tittleText))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (tittleText.count)))
        self.attributedText = attributedString
    }
}
