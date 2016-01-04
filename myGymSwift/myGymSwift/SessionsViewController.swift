//
//  SessionsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import FSCalendar
import JLToast

class SessionsViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var myCalendar: FSCalendar?
    let kShowDetailDay = "showDetailDay"
    var selectedDay: String = String()
    var selectedDate: NSDate = NSDate()
    var sessionsArray: Array<SessionObject> = Array<SessionObject>()
    var boolToast: Bool = Bool()
    var timer = NSTimer()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        myCalendar?.locale = NSLocale.init(localeIdentifier: FormaterManager.SharedInstance.fr_BI)
        myCalendar?.delegate = self
        myCalendar?.dataSource = self
        myCalendar?.appearance.headerMinimumDissolvedAlpha = 0.0
        myCalendar?.appearance.headerDateFormat = FormaterManager.SharedInstance.MMM
    }
    
    // MARK: - FSCalendar delegate
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {

        selectedDay =  FormaterManager.SharedInstance.formatWeekDayAndDate(date)
        selectedDate = date
        
        RealmManager.SharedInstance.isSessionWithDate(date) { (sessions) -> Void in
            
            self.sessionsArray.removeAll()
            
            for session in sessions {
                let sessionObject = SessionObject()
                sessionObject.setSessionForCell(session, completion: { (sessionObject) -> Void in
                    self.sessionsArray.append(sessionObject)
                })
            }
            if(sessions.count > 0) {
                self.performSegueWithIdentifier(self.kShowDetailDay, sender: self)
            }
            else{
                
                if(!self.timer.valid){
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(JLToastDelay.ShortDelay+1.0, target: self, selector: "countUp", userInfo: nil, repeats: false)
                    JLToast.makeText(NSLocalizedString("NOTHING", comment:"")+"\n"+self.selectedDay, duration: JLToastDelay.ShortDelay).show()
                }

                /*let alertController = UIAlertController(title: "", message: NSLocalizedString("NOTHING", comment:""), preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: NSLocalizedString("CLOSE", comment:""), style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: nil)*/
            }
        }
    }
    
    func minimumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        
        return NSDate()
    }
    
    func maximumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        
        let date = NSCalendar.currentCalendar().dateByAddingUnit(.WeekOfMonth, value: 1, toDate: NSDate(), options: [])

        return date
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == kShowDetailDay) {
            
            let svc = segue.destinationViewController as! DayViewController
            svc.sessionsArray = sessionsArray
            svc.selectedDay   = selectedDay
            svc.selectedDate  = selectedDate
        }
    }
    
    func countUp() {
        
        timer.invalidate()
    }
    
    // MARK: - Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
