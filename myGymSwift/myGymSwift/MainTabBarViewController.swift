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
        
        let colorSelection: UIColor = UIColor(red: 233.0/255.0, green: 145.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = colorSelection
        
        let firstTabBarItem:UITabBarItem  = tabBar.items![0]
        let secondTabBarItem:UITabBarItem = tabBar.items![1]
        let thirdTabBarItem:UITabBarItem  = tabBar.items![2]
        
        firstTabBarItem.selectedImage  = UIImage(named: ImagesConstants.tabBarSelectedImage0)
        secondTabBarItem.selectedImage = UIImage(named: ImagesConstants.tabBarSelectedImage1)
        thirdTabBarItem.selectedImage  = UIImage(named: ImagesConstants.tabBarSelectedImage2)

        firstTabBarItem.image  = UIImage(named: ImagesConstants.tabBarDefaultImage0)
        secondTabBarItem.image = UIImage(named: ImagesConstants.tabBarDefaultImage1)
        thirdTabBarItem.image  = UIImage(named: ImagesConstants.tabBarDefaultImage2)
        
        firstTabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13, weight: 2)], forState: .Normal)
        secondTabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13, weight: 2)], forState: .Normal)
        thirdTabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13, weight: 2)], forState: .Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
