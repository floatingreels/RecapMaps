//
//  PointOfJesus.swift
//  RecapMaps
//
//  Created by mobapp02 on 15/01/2020.
//  Copyright © 2020 Floating Reels. All rights reserved.
//

import UIKit
import MapKit

class PointOfJesus:NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    
    init(coordinate:CLLocationCoordinate2D, title:String?){
        self.coordinate = coordinate
        self.title = title
        subtitle = "Jesus not found"
    }
}
