//
//  SportModel.swift
//  myGymSwift
//
//  Created by julien gimenez on 06/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift

class SportModel: Object {
    
    dynamic var _id = ""
    dynamic var name = ""
    dynamic var _description = ""
    dynamic var color = ""
    dynamic var image = ""
}
