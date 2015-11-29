//
//  JsonManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 28/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import SwiftyJSON

class JsonManager: NSObject {

    static let sharedInstance = JsonManager()

    func groupsFromFile(fileName: String, object: String, completion:(result:JSON)->Void){

        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        let dataJson = NSData(contentsOfFile: path!)
        let json = JSON(data:dataJson!)
        completion(result: json[object])
    }
    
}
