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
    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.registerNib(UINib(nibName: "SessionTableViewCell", bundle: nil), forCellReuseIdentifier: "sessionIdentifier")
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
