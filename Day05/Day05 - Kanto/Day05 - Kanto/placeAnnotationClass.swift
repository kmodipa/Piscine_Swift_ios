//
//  placeAnnotationClass.swift
//  Day05 - Kanto
//
//  Created by Khomotjo MODIPA on 2018/10/08.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotationClass: NSObject, MKAnnotation {
    
    /* Properties */
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    /* Make map zoom in on location */
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}
