//
//  searchAndNavigateViewController.swift
//  Rush01-Plan42-GPS
//
//  Created by Khomotjo MODIPA on 2018/10/14.
//  Copyright © 2018 Khomotjo MODIPA. All rights reserved.
//

import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import MapKit


class searchAndNavigateViewController: UIViewController {

    /* Properties */
    var mapView: NavigationMapView!
    var viewControl = ViewController()
    var coordinateArray:[CLLocationDegrees] = []
    
     /* TextFields */
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    
    /* Labels */
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navigateButton(_ sender: UIButton) {
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        //Create the search result
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchTextField.text
        
        let  activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                print("lat \(String(describing: latitude)) long \(String(describing: longitude))")
                
                
//                let disneyland = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
//                let disneyland2 = CLLocationCoordinate2D(latitude: -26.1961663, longitude: 28.0481473)
//                self.viewControl.calculateRoute(from: disneyland2, to: disneyland, completion: { (route, error) in
//                    print("Hello")
//                })
            }
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let controller = segue.destination as! ViewController
//        controller.text = textField.text
//    }
    
    func returnCoord(lat: CLLocationDegrees, long: CLLocationDegrees) -> [CLLocationDegrees] {
        self.coordinateArray.append(lat)
        self.coordinateArray.append(long)
        return coordinateArray
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
