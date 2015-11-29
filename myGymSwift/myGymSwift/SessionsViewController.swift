//
//  SessionsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import FSCalendar
import SwiftyJSON
import RealmSwift

class SessionsViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource {

    let kFile = "sessionsFeed"
    let kKey = "sessions"
    @IBOutlet weak var myCalendar: FSCalendar?

    override func viewDidLoad() {
        super.viewDidLoad()

        myCalendar?.locale = NSLocale.init(localeIdentifier: "fr_BI")
        myCalendar?.delegate = self
        myCalendar?.dataSource = self
        myCalendar?.appearance.headerMinimumDissolvedAlpha = 0.0;

        JsonManager.sharedInstance .groupsFromFile(kFile, object:kKey) { (result) -> Void in
            let realm = try! Realm()
           
            // Clean DB
            try! realm.write {
                realm.deleteAll()
            }

            for(_,key)in result{
                
                // Format string to date
                let stringDate = key["day"].stringValue
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.dateFromString(stringDate)
                
                // Create a session object
                let session = SessionModel()
                session._id        = key["_id"].stringValue
                session.name       = key["name"].stringValue
                session.from       = key["from"].stringValue
                session.to         = key["to"].stringValue
                session.location   = key["location"].stringValue
                session.teacher_id = key["teacher_id"].stringValue
                session.day        = date!

                // Add to the Realm inside a transaction
                try! realm.write {
                    realm.add(session)
                }
            }
            
            // retrieves all Sessions from the default Realm
            let allSessions = realm.objects(SessionModel)
            print(allSessions)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
