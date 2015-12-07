//
//  SessionsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import FSCalendar
import RealmSwift

class SessionsViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var myCalendar: FSCalendar?
    let kShowDetailDay = "showDetailDay"
    let realmManager = RealmManager()
    let sessionManager = SessionManager()
    var sessionsArray: Array<SessionObject> = Array<SessionObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myCalendar?.locale = NSLocale.init(localeIdentifier: "fr_BI")
        myCalendar?.delegate = self
        myCalendar?.dataSource = self
        myCalendar?.appearance.headerMinimumDissolvedAlpha = 0.0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FSCalendar delegate
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        
        realmManager.isSessionWithDate(date) { (sessions) -> Void in
            
            self.sessionsArray.removeAll()
            
            for session in sessions {
                
                self.sessionManager.setSessionForCell(session, completion: { (sessionObject) -> Void in
                    self.sessionsArray.append(sessionObject)
                })
            }
            if(sessions.count > 0) {
                self.performSegueWithIdentifier(self.kShowDetailDay, sender: self)
            }
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == kShowDetailDay) {
            
            let svc = segue.destinationViewController as! DayViewController
            svc.sessionsArray = sessionsArray
        }
    }

}
