//
//  SportObject.swift
//  myGymSwift
//
//  Created by SQLI51109 on 18/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class SportObject: NSObject {
    
    dynamic var name = ""
    dynamic var _description = ""
    dynamic var color = UIColor()
    dynamic var image = ""

    func setSportForCell(sport: SportModel, completion: (sportObject: SportObject) -> Void) {
        
        let fullSport: SportObject = SportObject()
        fullSport.name             = sport.name
        fullSport._description     = sport.description_id
        fullSport.color            = FormaterManager.SharedInstance.uicolorFromHexa(sport.color)
        fullSport.image            = sport.image

        completion(sportObject: fullSport)
    }
    
    deinit{
        //print("Sport \(name) is being deinitialized")
    }
}
