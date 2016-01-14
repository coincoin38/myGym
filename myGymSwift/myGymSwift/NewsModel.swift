//
//  NewsModel.swift
//  myGymSwift
//
//  Created by SQLI51109 on 06/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import Foundation
import RealmSwift

class NewsModel: Object {
    
    dynamic var _id = ""
    dynamic var title = ""
    dynamic var _description = ""
    dynamic var day = NSDate()
}