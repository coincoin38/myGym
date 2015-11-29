//
//  SessionsViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import FSCalendar

class SessionsViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource {

    @IBOutlet weak var myCalendar: FSCalendar?

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
