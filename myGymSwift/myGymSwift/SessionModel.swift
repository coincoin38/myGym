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
    dynamic var name = ""
    dynamic var from = ""
    dynamic var to = ""
    dynamic var location = ""
    dynamic var teacher_id = ""
    dynamic var day = NSDate()
}
