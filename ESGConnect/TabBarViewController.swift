//
//  TabBarViewController.swift
//  ESG Connect
//
//  Created by Can Duru on 13.07.2023.
//

//MARK: Import
import UIKit

class TabBarViewController: UITabBarController {
    
//MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor(named: "AppBlueDarker")
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = UIColor(named: "AppYellow")
        setupVCs()
    }
    
    //MARK: Create ViewControllers
    func setupVCs() {
          viewControllers = [
            createNavController(for: HomeViewController(), title: NSLocalizedString("", comment: ""), image: UIImage(systemName: "house.fill")!.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "AppYellow")!)),
            createNavController(for: SubscriptionViewController(), title: NSLocalizedString("", comment: ""), image: UIImage(systemName: "creditcard.fill")!.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "AppYellow")!)),
            createNavController(for: ProfileViewController(), title: NSLocalizedString("", comment: ""), image: UIImage(systemName: "person.fill")!.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "AppYellow")!))
          ]
      }
    
    //MARK: Set Tabbar Items
    var i = -1
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: UIImage) -> UIViewController {
          let items = ["Home", "Subscription", "Profile"]
          i = i+1
          let navController = UINavigationController(rootViewController: rootViewController)

          navController.tabBarItem.title = items[i]
          navController.tabBarItem.image = image
          navController.navigationBar.prefersLargeTitles = false
          rootViewController.navigationItem.title = title
          return navController
      }
}
