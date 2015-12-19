//
//  SportsViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 18/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var sportsArray: Array<SportObject> = Array<SportObject>()
    private let reuseIdentifier = "SportIdentifier"
    @IBOutlet weak var sportsCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        sportsCollectionView?.registerNib(UINib(nibName: "SportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        RealmManager.SharedInstance.getAllSports { (sports) -> Void in
            
            self.sportsArray.removeAll()
            
            for sport in sports {
                let sportObject = SportObject()
                
                sportObject.setSportForCell(sport, completion: { (sportObject) -> Void in
                    self.sportsArray.append(sportObject)
                })
            }
        }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/3.5, height: 125)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SportCollectionViewCell
        cell.setData(sportsArray[indexPath.row])
        cell.contentView.frame = cell.bounds
        cell.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

