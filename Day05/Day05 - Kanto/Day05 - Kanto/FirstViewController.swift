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

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Do any additional setup after loading the view, typically from a nib. */
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = 10
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let placeCoordinates = CLLocationCoordinate2D(latitude: 48.8966105, longitude: 2.3163123)
        let placeAnnotation = PlaceAnnotationClass(coordinate: placeCoordinates, title: "42", subtitle: "Ecole trop style")
        
        mapView.addAnnotation(placeAnnotation)
        mapView.setRegion(placeAnnotation.region, animated: true)
        
    }
    
    /* Getting current user location */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Access the last object from locations to get perfect current location
        if let location = locations.last {
//            let span = MKCoordinateSpanMake(0.00575, 0.00575)
            let myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let placeAnnotation = PlaceAnnotationClass(coordinate: myLocation, title: "Home at weThinkCode", subtitle: "Home is where your code runs")
//            let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
            mapView.addAnnotation(placeAnnotation)
//            let region = MKCoordinateRegionMake(myLocation, span)
            mapView.setRegion(placeAnnotation.region, animated: true)
        }
        self.mapView.showsUserLocation = true
        manager.stopUpdatingLocation()
        /* Start here when the map starts */
        let fourtyTwo = CLLocationCoordinate2D(latitude: 48.8966105, longitude: 2.3163123)
        centerMapOnLocation(location: fourtyTwo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let placeAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
         placeAnnotationView.animatesWhenAdded = true
         placeAnnotationView.titleVisibility = .adaptive
            
            
            return placeAnnotationView
        }
        return nil
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    /* Switching the map type */
    @IBAction func changeMaptype(_ sender: UISegmentedControl) {
        mapView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
    }

    /* User location request */
    @IBAction func getUserLocation(_ sender: UIButton) {
        centerMapOnLocation(location: self.mapView.userLocation.coordinate)
    }
    
    
}

