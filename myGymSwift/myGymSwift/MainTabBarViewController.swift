//
//  MainTabBarViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 18/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorSelection: UIColor = UIColor(red: 226.0/255.0, green: 126.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = colorSelection
        
        let firstTabBarItem:UITabBarItem = tabBar.items![0]
        let secondTabBarItem:UITabBarItem = tabBar.items![1]
        let thirdTabBarItem:UITabBarItem = tabBar.items![2]
        
        firstTabBarItem.selectedImage  = UIImage(named: "News_selected")
        secondTabBarItem.selectedImage = UIImage(named: "Sessions_selected")
        thirdTabBarItem.selectedImage  = UIImage(named: "Sports_selected")

        firstTabBarItem.image  = UIImage(named: "News")
        secondTabBarItem.image = UIImage(named: "Sessions")
        thirdTabBarItem.image  = UIImage(named: "Sports")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
