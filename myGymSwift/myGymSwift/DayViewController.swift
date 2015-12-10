//
//  DayViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import RealmSwift

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sessionsArray: Array<SessionObject> = Array<SessionObject>()
    var selectedDay: String = String()
    var selectedDate : NSDate = NSDate()

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var dayPageIndicator: UIPageControl?


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.registerNib(UINib(nibName: "SessionTableViewCell", bundle: nil), forCellReuseIdentifier: "sessionIdentifier")
        dateLabel?.text = selectedDay
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        tableView!.reloadData()
        
        let cells = tableView!.visibleCells
        let tableHeight: CGFloat = tableView!.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.25, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }

    @IBAction func rightGesture(sender: UISwipeGestureRecognizer) {
        print ("Right")
        
        let components: NSDateComponents = NSDateComponents()
        components.setValue(-1, forComponent: NSCalendarUnit.Day);
        
        let previousDay   = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: selectedDate, options: NSCalendarOptions(rawValue: 0))
        
        
        RealmManager.SharedInstance.isSessionWithDate(previousDay!) { (sessions) -> Void in
            
            if(sessions.count>0){
                
                self.sessionsArray.removeAll()
                
                for session in sessions {
                    let sessionObject = SessionObject()
                    sessionObject.setSessionForCell(session, completion: { (sessionObject) -> Void in
                        self.sessionsArray.append(sessionObject)
                    })
                }
                if(self.sessionsArray.count > 0) {
                    self.dayPageIndicator?.currentPage--
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "EEEE dd"
                    dateFormatter.locale = NSLocale.init(localeIdentifier: "fr_BI")
                    self.selectedDay  = dateFormatter.stringFromDate(previousDay!).capitalizedString
                    self.dateLabel?.text = self.selectedDay
                    self.selectedDate = previousDay!
                    self.animateTable()
                }
            }
            else{
                print("nada right")
            }
        }
    }
    
    @IBAction func leftGesture(sender: UISwipeGestureRecognizer) {
        print ("Left")
        
        let components: NSDateComponents = NSDateComponents()
        components.setValue(1, forComponent: NSCalendarUnit.Day);
        
        let nextDay   = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: selectedDate, options: NSCalendarOptions(rawValue: 0))
        
        
        RealmManager.SharedInstance.isSessionWithDate(nextDay!) { (sessions) -> Void in
            
            if(sessions.count>0){
                
                self.sessionsArray.removeAll()
                
                for session in sessions {
                    let sessionObject = SessionObject()
                    sessionObject.setSessionForCell(session, completion: { (sessionObject) -> Void in
                        self.sessionsArray.append(sessionObject)
                    })
                }
                if(self.sessionsArray.count > 0) {
                    self.dayPageIndicator?.currentPage++
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "EEEE dd"
                    dateFormatter.locale = NSLocale.init(localeIdentifier: "fr_BI")
                    self.selectedDay =  dateFormatter.stringFromDate(nextDay!).capitalizedString
                    self.dateLabel?.text = self.selectedDay
                    self.selectedDate = nextDay!
                    self.animateTable()
                }
            }
            else{
                print("nada left")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("sessionIdentifier", forIndexPath: indexPath) as! SessionTableViewCell
        cell.setData(sessionsArray[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
