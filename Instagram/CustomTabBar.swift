//
//  CustomTabBar.swift
//  Instagram
//
//

import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())

        
        let controller = UINavigationController(rootViewController: collectionViewController)
        let controller2 = UINavigationController(rootViewController: HomeTableViewController())
        
        controller2.tabBarItem.image = #imageLiteral(resourceName: "feed_tab")
        controller2.tabBarItem.title  = "Home"
        controller.tabBarItem.title = "Profile"
        controller.tabBarItem.image = #imageLiteral(resourceName: "profile_tab")
        
        
        

    
            viewControllers = [ controller2, controller ]

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    

  

}
