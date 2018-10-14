//
//  ViewController.swift
//  Rush01-Plan42-GPS
//
//  Created by Khomotjo MODIPA on 2018/10/13.
//  Copyright © 2018 Khomotjo MODIPA. All rights reserved.
//

import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import MapKit
import CoreLocation

class ViewController: UIViewController, MGLMapViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    /* Properties */
    var mapBoxView: NavigationMapView! /* MapBox */
    var navigateButton: UIButton!
    var directionsRoute: Route?
    @IBOutlet weak var mapKitView: MKMapView! /* Mapkit */
    
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    
    let disneyland = CLLocationCoordinate2D(latitude: -26.1472491, longitude: 28.0348387)
//    let info = searchAndNavigateViewController().searchButton().latitude
    
    /* TextFields */
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    
    /* Labels */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.global().async { /* Enabling Multithreding */
            DispatchQueue.main.async {
                self.mapBoxView = NavigationMapView(frame: self.view.bounds) /* Make mapView cover the entire screen */
                self.mapBoxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                self.view.addSubview(self.mapView)
                self.mapBoxView.delegate = self
                self.mapBoxView.showsUserLocation = true
                self.mapBoxView.setUserTrackingMode(.follow, animated: true)
                
                /* MapKit Stuff */
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                //        locationManager.distanceFilter = 10
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.startUpdatingLocation()
                
                self.mapKitView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                
                let placeCoordinates = CLLocationCoordinate2D(latitude: 48.8966105, longitude: 2.3163123)
                let placeAnnotation = PlaceAnnotationClass(coordinate: placeCoordinates, title: "42", subtitle: "Ecole trop style")
                
                self.mapKitView.addAnnotation(placeAnnotation)
                self.mapKitView.setRegion(placeAnnotation.region, animated: true)
//                self.addButton()
            }
        }
        
        
    }
    
    /* The Navigation Button */
    @IBAction func navigateButton(_ sender: UIButton) {
        navigateButtonWasPressed(sender)
    }
    
    @objc func navigateButtonWasPressed(_ sender: UIButton) {
        mapBoxView.setUserTrackingMode(.none, animated: true)
        
        /* Adding Annotation */
        let annotation = MGLPointAnnotation()
        annotation.coordinate = disneyland
        annotation.title = "Start navigation"
        mapBoxView.addAnnotation(annotation)
        
        calculateRoute(from: (mapBoxView.userLocation!.coordinate), to: disneyland) { (route, error) in
            if error != nil
            {
                print("error setting route")
            }
        }
    }
    
    /* delegate method that allows annotations to show callouts when tapped */
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    /* Present the navigation view controller when the callout is selected */
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        let navigationViewController = NavigationViewController(for: directionsRoute!)
        self.present(navigationViewController, animated: true, completion: nil)
    }

    func calculateRoute(from originCor: CLLocationCoordinate2D, to destinationCor: CLLocationCoordinate2D, completion: @escaping (Route?, Error?) -> Void)
    {
        let origin = Waypoint(coordinate: originCor, coordinateAccuracy: -1, name: "Start")
        let destination = Waypoint(coordinate: destinationCor, coordinateAccuracy: -1, name: "Destination")
        
        let options = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
        
        _ = Directions.shared.calculate(options, completionHandler: { (waypoints, routes, error) in
            self.directionsRoute = routes?.first
            let navigationViewController = NavigationViewController(for: self.directionsRoute!)
            self.present(navigationViewController, animated: true, completion: nil)
        })
        
    }
    
    func drawRoute(route: Route) {
        guard route.coordinateCount > 0 else { return }
        // Convert the route’s coordinates into a polyline
        var routeCoordinates = route.coordinates!
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: route.coordinateCount)
        
        // If there's already a route line on the map, reset its shape to the new route
        if let source = mapBoxView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            
            // Customize the route line color and width
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.1897518039, green: 0.3010634184, blue: 0.7994888425, alpha: 1))
            lineStyle.lineWidth = NSExpression(forConstantValue: 3)
            
            // Add the source and style layer of the route line to the map
            mapBoxView.style?.addSource(source)
            mapBoxView.style?.addLayer(lineStyle)
        }
    }
    
    /* Getting current user location */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Access the last object from locations to get perfect current location
        if let location = locations.last {
            let myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let placeAnnotation = PlaceAnnotationClass(coordinate: myLocation, title: "Home at weThinkCode", subtitle: "Home is where your code runs")
            mapKitView.addAnnotation(placeAnnotation)
            mapKitView.setRegion(placeAnnotation.region, animated: true)
        }
        self.mapKitView.showsUserLocation = true
        manager.stopUpdatingLocation()
        /* Start here when the map starts */
        let fourtyTwo = CLLocationCoordinate2D(latitude: 48.8966105, longitude: 2.3163123)
        centerMapOnLocation(location: fourtyTwo)
    }
    
    /* Search handler */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        self.view.addSubview(activityIndicator)
        
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search result
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let  activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.mapKitView.annotations
                self.mapKitView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapKitView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapKitView.setRegion(region, animated: true)
                
            }
        }
        
        
    }
    
    /* Search Button */
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    
    @nonobjc func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
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
        mapKitView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func getUserLocation(_ sender: UIButton) {
        centerMapOnLocation(location: self.mapKitView.userLocation.coordinate)
    }
    
    /* Switching the map type */
    @IBAction func changeMap(_ sender: UISegmentedControl) {
         mapKitView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

