//
//  FAQViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 17.07.2023.
//

//MARK: Import
import UIKit
import WebKit

class FAQViewController: UIViewController, WKNavigationDelegate {

    //MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Set Up
        let webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

        //MARK: Web URL
        let url = URL(string: "https://theworkable.co")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
