//
//  SearchingViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 13.07.2023.
//

//MARK: Import
import UIKit
import WebKit
import FirebaseDatabase

class SubscriptionViewController: UIViewController {

//MARK: Set Up
    
    
    
    //MARK: Set Variables
    var websitelink = ""
    


//MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBlue")
        
        //MARK: Set Labels
        setupLabels()
    }


//MARK: Set Up Layout
    func setupLabels(){
        
        
        //MARK: Title Label Feature
        let titleLabel = UILabel()
        titleLabel.text = "Subscription Plans"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.underline()
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)])
        
        //MARK: Image Feature
        let imageLogo = UIImage(named: "Logo")
        let imageView = UIImageView(image: imageLogo)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10), imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
        
        //MARK: Bullet Points Label Feature
        let bulletPointsLabel = UILabel()
        let bulletPoints = [
            "Easy to communicate",
            "Access different locations",
            "Remove Viewer Limit",
            "Learn Who Visited Your Profile",
            "Enable Direct Communication",
            "Get Special Campaigns for Premium Users",
            "Advertise Your Profile"
        ]
        let bulletList = bulletPoints.map { "- \($0)" }
        bulletPointsLabel.text = bulletList.joined(separator: "\n")
        bulletPointsLabel.numberOfLines = -1
        bulletPointsLabel.textColor = .white
        view.addSubview(bulletPointsLabel)
        
        bulletPointsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bulletPointsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), bulletPointsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10), bulletPointsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), bulletPointsLabel.heightAnchor.constraint(equalToConstant: 200)])

        //MARK: Development Label Feature
        let developmentLabel = UILabel()
        developmentLabel.textColor = .white
        developmentLabel.text = "This application is in the development process. These features will be added in the future."
        developmentLabel.numberOfLines = -1
        developmentLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(developmentLabel)
        
        developmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([developmentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), developmentLabel.topAnchor.constraint(equalTo: bulletPointsLabel.bottomAnchor, constant: 10), developmentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), developmentLabel.heightAnchor.constraint(equalToConstant: 40)])

        //MARK: Stripe Link Button Feature
        let stripeLinkButton = UIButton()
        stripeLinkButton.setTitle("Stripe Link for Pre-Payment", for: .normal)
        stripeLinkButton.backgroundColor = UIColor(named: "AppYellow")
        stripeLinkButton.layer.cornerRadius = 5
        stripeLinkButton.clipsToBounds = true
        stripeLinkButton.addTarget(self, action: #selector(openStripeLink), for: .touchUpInside)
        view.addSubview(stripeLinkButton)
        
        stripeLinkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stripeLinkButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), stripeLinkButton.topAnchor.constraint(equalTo: developmentLabel.bottomAnchor, constant: 10), stripeLinkButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), stripeLinkButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20), stripeLinkButton.heightAnchor.constraint(equalToConstant: 35)])
    }

   
    
//MARK: Payment Button Action
    @objc private func openStripeLink() {
        
        let webView = WKWebView(frame: self.view.bounds)
        websiteData {
            let url = URL(string: self.websitelink)!
            webView.load(URLRequest(url: url))
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            webView.allowsBackForwardNavigationGestures = false
        }
         
        let viewController = UIViewController()
        viewController.view = webView

        //MARK: Back Button Set Up
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "arrow.backward")?.withTintColor(UIColor(named: "AppYellow")!, renderingMode: .alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(self_dismiss), for: .touchUpInside)
        viewController.view.addSubview(backButton)
        backButton.contentHorizontalAlignment = .fill
        backButton.contentVerticalAlignment = .fill
        backButton.imageView?.contentMode = .scaleAspectFit

        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backButton.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor, constant: 16), backButton.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 13), backButton.widthAnchor.constraint(equalToConstant: 30), backButton.heightAnchor.constraint(equalToConstant: 30)])
         
        viewController.title = "Stripe Link"
        self.present(viewController, animated: true)
     }
    
    
    
//MARK: Back Button Action
    @objc func self_dismiss(){
        self.dismiss(animated: true)
    }
    
    
    
//MARK: Website Link Data
    func websiteData(completion: @escaping () -> ()){
        let ref = Database.database(url: "https://esgconnect-2023-default-rtdb.firebaseio.com/").reference()
        ref.observeSingleEvent(of: .value) { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    return
                }
                self.websitelink = dict["payment"] as! String
                completion()
            }
        }
    }
}
