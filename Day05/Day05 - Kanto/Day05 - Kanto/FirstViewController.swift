//
//  FirstViewController.swift
//  Day05 - Kanto
//
//  Created by Khomotjo MODIPA on 2018/10/08.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Do any additional setup after loading the view, typically from a nib. */
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let placeCoordinates = CLLocationCoordinate2D(latitude: 48.8966105, longitude: 2.3163123)
        let placeAnnotation = PlaceAnnotationClass(coordinate: placeCoordinates, title: "42", subtitle: "Ecole trop style")
        
        mapView.addAnnotation(placeAnnotation)
        mapView.setRegion(placeAnnotation.region, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let placeAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
         placeAnnotationView.animatesWhenAdded = true
         placeAnnotationView.titleVisibility = .adaptive
            
            
            return placeAnnotationView
        }
        return nil
    }
}

