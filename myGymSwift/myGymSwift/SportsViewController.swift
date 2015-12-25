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
    let kShowDetailSport = "showDetailSport"
    @IBOutlet weak var sportsCollectionView: UICollectionView?
    var sport: SportObject = SportObject()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true) //or animated: false

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
    
    // MARK: - Collection delegate

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SportCollectionViewCell
        cell.setData(sportsArray[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        sport = sportsArray[indexPath.row]
        self.performSegueWithIdentifier(kShowDetailSport, sender: self)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == kShowDetailSport) {
            let sdvc = segue.destinationViewController as! SportDetailsViewController
            
            let objectivesObject = ObjectivesObject()
            objectivesObject.setObjectives(sport, completion: { (objectivesObject) -> Void in
        
                sdvc.objectivesArray = objectivesObject
                sdvc.sport = self.sport
            })
        }
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

