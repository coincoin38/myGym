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
        //navigationController?.navigationBarHidden = false
        title = sport.name
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = sport.color

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let newBackButton = UIBarButtonItem(title: "Retour", style: UIBarButtonItemStyle.Done, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back(sender: UIBarButtonItem) {
        reloadNavBar()
        navigationController?.popViewControllerAnimated(true)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            reloadNavBar()
            navigationController?.popViewControllerAnimated(true)
            return true
        }
        return false
    }
    
    func reloadNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
