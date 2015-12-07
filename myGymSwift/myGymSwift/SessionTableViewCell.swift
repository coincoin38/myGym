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
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(session: SessionObject) {
        sessionLabel?.text = session.sportName
        coachLabel?.text   = session.teacherName
        fromLabel?.text    = session.from
        toLabel?.text      = session.to
    }
}
