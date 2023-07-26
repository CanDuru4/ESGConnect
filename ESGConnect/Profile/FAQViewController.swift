//
//  FAQViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 17.07.2023.
//

//MARK: Import
import UIKit
import WebKit
import FirebaseDatabase

class FAQViewController: UIViewController, WKNavigationDelegate {

    //MARK: Load
    var websitelink = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Set Up
        let webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

        //MARK: Web URL
        websiteData {
            let url = URL(string: self.websitelink)!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = false
        }
    }
    
    func websiteData(completion: @escaping () -> ()){
        let ref = Database.database(url: "https://esgconnect-2023-default-rtdb.firebaseio.com/").reference()
        ref.observeSingleEvent(of: .value) { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    return
                }
                self.websitelink = dict["faq"] as! String
                completion()
            }
        }
    }
}
