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

class ViewController: UIViewController, MGLMapViewDelegate {
    
    /* Properties */
    var mapView: NavigationMapView!
    var navigateButton: UIButton!
    var directionsRoute: Route?
    let disneyland = CLLocationCoordinate2D(latitude: -26.1472491, longitude: 28.0348387)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.global().async { /* Enabling Multithreding */
            DispatchQueue.main.async {
                self.mapView = NavigationMapView(frame: self.view.bounds) /* Make mapView cover the entire screen */
                self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.view.addSubview(self.mapView)
                self.mapView.delegate = self
                self.mapView.showsUserLocation = true
                self.mapView.setUserTrackingMode(.follow, animated: true)
                self.addButton()
            }
        }
        
        
    }
    
    func addButton() {
        navigateButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 100, y: view.frame.height - 75, width: 200, height: 50))
        navigateButton.backgroundColor = .white
        navigateButton.setTitle("Navigate", for: .normal)
        navigateButton.setTitleColor(UIColor(red: 59/255, green: 178/255, blue: 208/255, alpha: 1), for: .normal)
        navigateButton.titleLabel?.font = UIFont(name: "AvenicNext-DeniBold", size: 10)
        navigateButton.layer.cornerRadius = 25
        navigateButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        navigateButton.layer.shadowColor = UIColor.black.cgColor
        navigateButton.layer.shadowRadius = 5
        navigateButton.layer.shadowOpacity = 0.3
        navigateButton.addTarget(self, action: #selector(navigateButtonWasPressed(_:)), for: .touchUpInside)
        view.addSubview(navigateButton)
    }
    
    @objc func navigateButtonWasPressed(_ sender: UIButton) {
        mapView.setUserTrackingMode(.none, animated: true)
        
        /* Adding Annotation */
        let annotation = MGLPointAnnotation()
        annotation.coordinate = disneyland
        annotation.title = "Start navigation"
        mapView.addAnnotation(annotation)
        
        calculateRoute(from: (mapView.userLocation!.coordinate), to: disneyland) { (route, error) in
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
            /* Draw Route here */
            self.drawRoute(route: self.directionsRoute!)
            
            let coordinatesBounds = MGLCoordinateBounds(sw: destinationCor, ne: originCor)
            let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            let routeCam = self.mapView.cameraThatFitsCoordinateBounds(coordinatesBounds, edgePadding: insets)
            self.mapView.setCamera(routeCam, animated: true)
        })
        
    }
    
    func drawRoute(route: Route) {
        guard route.coordinateCount > 0 else { return }
        // Convert the route’s coordinates into a polyline
        var routeCoordinates = route.coordinates!
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: route.coordinateCount)
        
        // If there's already a route line on the map, reset its shape to the new route
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            
            // Customize the route line color and width
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.1897518039, green: 0.3010634184, blue: 0.7994888425, alpha: 1))
            lineStyle.lineWidth = NSExpression(forConstantValue: 3)
            
            // Add the source and style layer of the route line to the map
            mapView.style?.addSource(source)
            mapView.style?.addLayer(lineStyle)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

