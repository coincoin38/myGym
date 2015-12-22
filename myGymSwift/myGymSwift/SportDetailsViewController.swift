//
//  SportDetailsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 21/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportDetailsViewController: UIViewController,UIGestureRecognizerDelegate {

    var sport: SportObject = SportObject()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        configureStyleNavBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        NavBarManager.SharedInstance.resetNavBar(navigationController!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureStyleNavBar(){
        
        //NavBar
        title = sport.name
        NavBarManager.SharedInstance.configureNavBarWithColors(navigationController!, backgroundColor: sport.color, textColor: UIColor.whiteColor())
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //Back button
        let newBackButton = UIBarButtonItem(title: "Retour", style: UIBarButtonItemStyle.Done, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        //StatusBar
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    func back(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            navigationController?.popViewControllerAnimated(true)
            return true
        }
        return false
    }
}
