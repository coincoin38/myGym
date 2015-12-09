//
//  SessionTableViewCell.swift
//  myGymSwift
//
//  Created by julien gimenez on 05/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!
    @IBOutlet weak var attendanceView: UIView!
    
    //#b1be9b
    let colorFullAttendance: UIColor = UIColor(red: 177.0/255.0, green: 190.0/255.0, blue: 155.0/255.0, alpha: 1.0)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(session: SessionObject) {
        sessionLabel?.text   = session.sportName
        sessionLabel?.textColor   = session.colorSport

        coachLabel?.text     = session.teacherName
        fromLabel?.text      = session.from
        durationLabel?.text  = session.duration+"min"

        if(Int(session.attendance) == 0){
            attendanceView.backgroundColor = colorFullAttendance
        }
    }
}
