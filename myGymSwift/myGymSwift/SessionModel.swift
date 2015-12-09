//
//  SessionModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift

class SessionModel: Object {
    
    dynamic var _id = ""
    dynamic var sport_id = ""
    dynamic var from = ""
    dynamic var duration = ""
    dynamic var location = ""
    dynamic var teacher_id = ""
    dynamic var attendance = ""
    dynamic var day = NSDate()
}
