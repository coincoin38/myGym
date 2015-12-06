//
//  DayViewController.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import RealmSwift

class DayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var sessions:Results<SessionModel>!
    let realmManager = RealmManager()
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
        return sessions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("sessionIdentifier", forIndexPath: indexPath) as! SessionTableViewCell
        // A sortir d'ici pour éviter des requêtes à chaque scroll
        let _idSport : String = sessions[indexPath.row].sport_id
        realmManager.getSportWithId(_idSport) { (sport) -> Void in
            cell.sessionLabel?.text = sport[0].name
        }
        
        let _idTeacher : String = sessions[indexPath.row].teacher_id
        realmManager.getTeacherWithId(_idTeacher) { (teacher) -> Void in
            cell.coachLabel?.text = teacher[0].name+" "+teacher[0].first_name
        }
        
        cell.fromLabel?.text = sessions[indexPath.row].from
        cell.toLabel?.text = sessions[indexPath.row].to
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
