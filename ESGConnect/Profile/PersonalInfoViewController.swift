//
//  PersonalInfoViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 17.07.2023.
//

//MARK: Import
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class PersonalInfoViewController: UIViewController {
    
//MARK: Set Up
    
    
    
    //MARK: Set Variables
    var nameField = UITextField()
    var emailField = UITextField()
    var currentpasswordField = UITextField()
    var passwordField = UITextField()
    var passwordAuthenticateField = UITextField()
    var locationField = UITextField()
    var socialField = UITextField()
    var education_employeeField = UITextField()
    var saveButton = UIButton()
    var useruid = (Auth.auth().currentUser?.uid)!
    var userprofile = ""

    
//MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBlue")
        setLabels()
        getUserData()
        
        //MARK: Hide Keyboard
        self.hideKeyboardWhenTappedAround()
    }


    
//MARK: Variable Features
    func setLabels(){
        
        
        //MARK: Image Features
        let imageCan = UIImage(named: "Logo")
        let imageView = UIImageView(image: imageCan)
        imageView.clipsToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        //MARK: Name Field Features
        nameField.placeholder = "Name / Company Name"
        nameField.borderStyle = .roundedRect
        nameField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        nameField.layer.borderWidth = CGFloat(1)
        nameField.autocorrectionType = .no
        view.addSubview(nameField)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Email Field Features
        emailField.placeholder = "Email"
        emailField.borderStyle = .roundedRect
        emailField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        emailField.layer.borderWidth = CGFloat(1)
        emailField.autocorrectionType = .no
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false

        //MARK: Current Password Field Features
        currentpasswordField.placeholder = "Current Password"
        currentpasswordField.borderStyle = .roundedRect
        currentpasswordField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        currentpasswordField.layer.borderWidth = CGFloat(1)
        view.addSubview(currentpasswordField)
        currentpasswordField.isSecureTextEntry = true
        currentpasswordField.autocorrectionType = .no
        currentpasswordField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: New Password Field Features
        passwordField.placeholder = "New Password"
        passwordField.borderStyle = .roundedRect
        passwordField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        passwordField.layer.borderWidth = CGFloat(1)
        view.addSubview(passwordField)
        passwordField.isSecureTextEntry = true
        passwordField.autocorrectionType = .no
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Authenticate Password Field Features
        passwordAuthenticateField.placeholder = "New Password Authenticate"
        passwordAuthenticateField.borderStyle = .roundedRect
        passwordAuthenticateField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        passwordAuthenticateField.layer.borderWidth = CGFloat(1)
        view.addSubview(passwordAuthenticateField)
        passwordAuthenticateField.isSecureTextEntry = true
        passwordAuthenticateField.autocorrectionType = .no
        passwordAuthenticateField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Location Field Feature
        locationField.placeholder = "Location (optional)"
        locationField.borderStyle = .roundedRect
        locationField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        locationField.layer.borderWidth = CGFloat(1)
        view.addSubview(locationField)
        locationField.autocapitalizationType = .none
        locationField.autocorrectionType = .no
        locationField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Education Field Feature
        education_employeeField.placeholder = "Education Status (optional)"
        education_employeeField.borderStyle = .roundedRect
        education_employeeField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        education_employeeField.layer.borderWidth = CGFloat(1)
        view.addSubview(education_employeeField)
        education_employeeField.autocapitalizationType = .none
        education_employeeField.autocorrectionType = .no
        education_employeeField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Website  Field Feature
        socialField.placeholder = "Website URL (optional)"
        socialField.borderStyle = .roundedRect
        socialField.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        socialField.layer.borderWidth = CGFloat(1)
        view.addSubview(socialField)
        socialField.autocapitalizationType = .none
        socialField.autocorrectionType = .no
        socialField.translatesAutoresizingMaskIntoConstraints = false

        //MARK: Save Button Field Features
        saveButton.backgroundColor = UIColor(named: "AppYellow")
        saveButton.setTitle("Update User", for: .normal)
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = 15
        saveButton.clipsToBounds = true
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        

        //MARK: Constraints
        NSLayoutConstraint.activate([
            
            
            //MARK: Image Constraints
            imageView.centerXAnchor.constraint(equalTo: nameField.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameField.topAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            //MARK: Name Field Constraints
            nameField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            nameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameField.heightAnchor.constraint(equalToConstant: 35),
            
            //MARK: Email Field Constraints
            emailField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 5),
            emailField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 35),
            
            //MARK: Current Field Constraints
            currentpasswordField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            currentpasswordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 5),
            currentpasswordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            currentpasswordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            currentpasswordField.heightAnchor.constraint(equalToConstant: 35),
            
            //MARK: Password Field Constraints
            passwordField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: currentpasswordField.bottomAnchor, constant: 5),
            passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 35),
            
            //MARK: Password Authenticate Field Constraints
            passwordAuthenticateField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordAuthenticateField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 5),
            passwordAuthenticateField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordAuthenticateField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordAuthenticateField.heightAnchor.constraint(equalToConstant: 35),
            
            //MARK: Location Field Constraints
            locationField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            locationField.topAnchor.constraint(equalTo: passwordAuthenticateField.bottomAnchor, constant: 5),
            locationField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            locationField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            locationField.heightAnchor.constraint(equalToConstant: 35),
            
            //MARK: Employee Number / Education Status Field Constraints
            education_employeeField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            education_employeeField.topAnchor.constraint(equalTo: locationField.bottomAnchor, constant: 5),
            education_employeeField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            education_employeeField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            education_employeeField.heightAnchor.constraint(equalToConstant: 35),

            //MARK: Social Field Constraints
            socialField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            socialField.topAnchor.constraint(equalTo: education_employeeField.bottomAnchor, constant: 5),
            socialField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            socialField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            socialField.heightAnchor.constraint(equalToConstant: 35),
            
            //MARK: Save Button Constraints
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
  
    
    
//MARK: Update User Button Action
    @objc func updateUser(){
        
        
        //MARK: Validate Fields
        let error = validateFields()
    
        if error != nil {

        } else {
            //MARK: Name, Email, and Password Field Checked
            let user = Auth.auth().currentUser
            let email = user?.email?.lowercased()
            let password = currentpasswordField.text
            Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                if error != nil {
                    
                    //MARK: User Current Password Wrong
                    let alert = UIAlertController(title: "Current password is not correct. Check your current password.", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    strongSelf.present(alert, animated: true, completion: nil)
                } else {
                    
                    //MARK: User Current Password Correct
                    self?.changeuser()
                }
            }
        }
    }
    
    

//MARK: Get User Data
func getUserData(){
    let user = Auth.auth().currentUser
    let db = Firestore.firestore()
    db.collection("users").document(useruid)
        .addSnapshotListener { documentSnapshot, error in
          guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
          }
            
            
            guard let dataUser = document.data()?["userprofile"] else {
                print("Document data was empty.")
                return
            }
            self.userprofile = dataUser as! String
            if dataUser as! String == "employee" {
                guard let dataName = document.data()?["name"] else {
                    print("Document data was empty.")
                    return
                }
                guard let dataEducation = document.data()?["educationstatus"] else {
                    print("Document data was empty.")
                    return
                }
                guard let dataSocial = document.data()?["social"] else {
                    print("Document data was empty.")
                    return
                }
                guard let dataLocation = document.data()?["location"] else {
                    print("Document data was empty.")
                    return
                }
                
                self.nameField.text = dataName as? String ?? ""
                self.emailField.text = user?.email
                self.socialField.text = dataSocial as? String ?? ""
                self.education_employeeField.text = dataEducation as? String ?? ""
                self.locationField.text = dataLocation as? String ?? ""
            }
            if dataUser as! String == "company" {
                guard let dataName = document.data()?["name"] else {
                    print("Document data was empty.")
                    return
                }
                guard let dataEducation = document.data()?["employeenumber"] else {
                    print("Document data was empty.")
                    return
                }
                guard let dataSocial = document.data()?["website"] else {
                    print("Document data was empty.")
                    return
                }
                guard let dataLocation = document.data()?["location"] else {
                    print("Document data was empty.")
                    return
                }
                
                self.nameField.text = dataName as? String ?? ""
                self.emailField.text = user?.email
                self.socialField.text = dataSocial as? String ?? ""
                self.education_employeeField.text = dataEducation as? String ?? ""
                self.locationField.text = dataLocation as? String ?? ""
            }
    }
}
    

//MARK: Update User Function
    func changeuser(){
        let changeName =  nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let changeEmail = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let changePassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let changeSocial = socialField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let changeLocation = locationField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let changeEducation_Employee = education_employeeField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        let db = Firestore.firestore()
        
        //MARK: Update User Name
        if userprofile == "employee" {
            db.collection("users").document(useruid).updateData(["name":changeName, "educationstatus": changeEducation_Employee, "social": changeSocial, "location": changeLocation]) { (error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "An error occured. Try again.", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else if userprofile == "company" {
            db.collection("users").document(useruid).updateData(["name":changeName, "employeenumber": changeEducation_Employee, "website": changeSocial, "location": changeLocation]) { (error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "An error occured. Try again.", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }

        
        //MARK: Update Email
        Auth.auth().currentUser?.updateEmail(to: changeEmail) { (error) in
            if error != nil {
                let alert = UIAlertController(title: "An error occured. Try again.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        //MARK: Update Password
        let error = validatePasswordChange()
        if error != nil
        {
            
            //MARK: Password Change Not Wanted
            let alert = UIAlertController(title: "Please enter new password.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            //MARK: Password Change Wanted
            let error_pass = validatePasswords()
            if error_pass != nil {
            } else {
                
                //MARK: Passwords Matched
                Auth.auth().currentUser?.updatePassword(to: changePassword) {  (error) in
                    if error != nil {
                        let alert = UIAlertController(title: "An error occured. Try again.", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "User information updates.", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
            }
        }
    }
    

    
//MARK: Validate Password Change
    func validatePasswordChange() -> String? {
        
        if passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordAuthenticateField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "şifre değişimi yok"
        }
        return nil
    }
    
    

//MARK: Validate Match Between Password
    func validatePasswords() -> String? {
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let authenticatecleanedPassword = passwordAuthenticateField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedPassword != authenticatecleanedPassword{
            let alert = UIAlertController(title: "New password and authentication password do not match. Try again.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return "Doğrulama şifreniz ile girdiğiniz şifre uyuşmuyor. "
        }
        
        //MARK: Password Requirements Not Matched
        if isPasswordValid(cleanedPassword) == false {
            let alert = UIAlertController(title: "New password should be at least 8 characters and include special character.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return "Lütfen şifrenizin en az 8 karakter olduğundan, özel bir karakter (!,?,&,...) ve bir sayı içerdiğinden emin olun."

        }
        return nil
    }
    
    
    
//MARK: Valite Name, Email, and Current Password Field
    func validateFields() -> String? {
        if nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            currentpasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let alert = UIAlertController(title: "Please fill the all blanks.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return "Lütfen bütün boşlukları doldurun."
        }
        return nil
    }
        


//MARK: Password Requirements
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
