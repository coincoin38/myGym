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
    var objectivesArray: Array<ObjectiveObject> = Array<ObjectiveObject>()


    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        sportDescriptionTextView.text = sport._description
        sportDescriptionTextView.textAlignment = .Justified
        sportDescriptionTextView.font = UIFont.systemFontOfSize(14, weight: 0)
        
        objectivesCollectionView?.registerNib(UINib(nibName: "ObjectiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        /*
        let url = NSURL (string: "https://youtu.be/8YOq_NOmI6I");
        let requestObj = NSURLRequest(URL: url!);
        videoWebView.loadRequest(requestObj);
        
        sportLabel.text = String(format: NSLocalizedString("WHAT_IS_SPORT", comment:""),sport.name)

        */
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        configureStyleNavBar()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
       // NavBarManager.SharedInstance.resetNavBar(navigationController!)
    }

    func configureStyleNavBar(){
        
        //NavBar
        title = sport.name
        NavBarManager.SharedInstance.configureNavBarWithColors(navigationController!, backgroundColor: sport.color, textColor: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor))
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //Back button
        let newBackButton = UIBarButtonItem(title: NSLocalizedString("BACK", comment:""), style: UIBarButtonItemStyle.Done, target: self, action: "back:")
        newBackButton.setTitleTextAttributes([NSForegroundColorAttributeName: FormaterManager.SharedInstance.uicolorFromHexa(ColorsConstants.navBarTextAlternColor),NSFontAttributeName:UIFont.systemFontOfSize(18, weight: 2)], forState: UIControlState.Normal)

        self.navigationItem.leftBarButtonItem = newBackButton;
        
        
        //StatusBar
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    // MARK: - Actions
    
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
    
    // MARK: - Collection delegate

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectivesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ObjectiveCollectionViewCell
        cell.setData(objectivesArray[indexPath.row])

        return cell
    }
    
    // MARK: - Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
