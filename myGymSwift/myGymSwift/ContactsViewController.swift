//
//  ContactViewController.swift
//  myGymSwift
//
//  Created by SQLI51109 on 27/01/2016.
//  Copyright © 2016 julien gimenez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ContactsViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        openMapForPlace()
    }

    func openMapForPlace() {
        
        let lat1 : NSString = "45.744127"
        let lng1 : NSString = "4.871262"
        
        let latitute:CLLocationDegrees =  lat1.doubleValue
        let longitute:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Win Fitness"
        mapItem.openInMapsWithLaunchOptions(options)
        
    }
}
