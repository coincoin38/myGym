//
//  SportDetailsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 21/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportDetailsViewController: UIViewController,UIGestureRecognizerDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    var sport: SportObject = SportObject()
    @IBOutlet weak var sportDescriptionTextView: UITextView!
    @IBOutlet weak var objectivesCollectionView: UICollectionView?
    private let reuseIdentifier = "ObjectiveIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        sportDescriptionTextView.text = sport._description
        sportDescriptionTextView.textAlignment = .Justified
        objectivesCollectionView?.registerNib(UINib(nibName: "ObjectiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        /*
        let url = NSURL (string: "https://youtu.be/8YOq_NOmI6I");
        let requestObj = NSURLRequest(URL: url!);
        videoWebView.loadRequest(requestObj);
        
        sportLabel.text = String(format: NSLocalizedString("WHAT_IS_SPORT", comment:""),sport.name)

        */
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true) //or animated: false
        configureStyleNavBar()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true) //or animated: false
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
       // NavBarManager.SharedInstance.resetNavBar(navigationController!)
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ObjectiveCollectionViewCell
        return cell
    }
}
