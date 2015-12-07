//
//  FormaterManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 05/12/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit

class FormaterManager: NSObject {

    func formatyyyMMddFromString(dateString:String) ->NSDate{

        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyy-MM-dd"
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")

        let dateFromString :NSDate = formatter.dateFromString(dateString)!
        
        return dateFromString
    }
    
    func isSameDayWithDate1(date1:NSDate,date2:NSDate) ->Bool{
        
        let cal = NSCalendar.currentCalendar()
        var components = cal.components([.Era, .Year, .Month, .Day], fromDate:date1)
        let today = cal.dateFromComponents(components)!
        
        components = cal.components([.Era, .Year, .Month, .Day], fromDate:date2);
        let otherDate = cal.dateFromComponents(components)!
        
        if(today.isEqualToDate(otherDate)) {
            return true
        }
        return false
    }
}
