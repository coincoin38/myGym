//
//  TeacherModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift

class TeacherModel: Object {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var first_name = ""
    dynamic var _description = ""
    dynamic var photo = ""
    dynamic var agency = ""
}
