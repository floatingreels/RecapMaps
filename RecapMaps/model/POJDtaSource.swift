//
//  POJDtaSource.swift
//  RecapMaps
//
//  Created by mobapp02 on 15/01/2020.
//  Copyright © 2020 Floating Reels. All rights reserved.
//

import Foundation
import MapKit

class POJDataSource{
    var points:[PointOfJesus]
    
    init(){
        points = [PointOfJesus]()
        
        let pojVatican = PointOfJesus.init(coordinate: CLLocationCoordinate2DMake(41.9029, 12.4534), title: "Vatican")
        points.append(pojVatican)
        
        let pojSantiago = PointOfJesus.init(coordinate: CLLocationCoordinate2DMake(42.8782, 8.5448), title: "Santiago de Compostella")
        points.append(pojSantiago)
        
        let pojSistine = PointOfJesus.init(coordinate: CLLocationCoordinate2DMake(41.9029, 12.4545), title: "Sistine Chapel")
        points.append(pojSistine)
        
        let pojCristoRedentor = PointOfJesus.init(coordinate: CLLocationCoordinate2DMake(-22.9519, -43.2105), title: "Cristo Redentor")
               points.append(pojCristoRedentor)
        
        let pojAntwerp = PointOfJesus.init(coordinate: CLLocationCoordinate2DMake(51.2203, 4.4015), title: "Antwerp Cathedral")
        points.append(pojAntwerp)
        
        let pojBethlehem = PointOfJesus.init(coordinate: CLLocationCoordinate2DMake(31.7054, 35.2024), title: "Bethlehem")
        points.append(pojBethlehem)
        
        let pojJerusalem = PointOfJesus.init(coordinate: CLLocationCoordinate2DMake(31.7683, 35.2137), title: "Jerusalem")
        points.append(pojJerusalem)
        
        let pojCanterbury = PointOfJesus.init(coordinate: CLLocationCoordinate2DMake(51.279999, 1.080000), title: "Canterbury")
        points.append(pojCanterbury)
                
    }
}
