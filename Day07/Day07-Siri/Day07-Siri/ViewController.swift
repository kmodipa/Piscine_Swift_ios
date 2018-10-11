//
//  ViewController.swift
//  Day07-Siri
//
//  Created by Khomotjo MODIPA on 2018/10/11.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController, UIPageViewControllerDelegate {
    
    var bot : RecastAIClient?
    let client = DarkSkyClient(apiKey: "7a12d77357302894a3b44e1fa4014bdc") /* Dark Sky API */
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    @IBAction func responseButton(_ sender: UIButton) {
        makeRequest()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bot = RecastAIClient(token : "4f22136e9fbc9909f579d4f28f2ebd1d", language: "en") /* RecastAI */
    }
    
    func makeRequest()
    {
        //Call makeRequest with string parameter to make a text request
        if self.myTextField.text?.isEmpty ?? true
        {
            self.myLabel.text = "Pleace Enter a place name"
        }
        else
        {
            self.bot?.textRequest(myTextField.text!, successHandler: recastRequestDone, failureHandle: recastRequestNotDone)
        }
    }
    
    
    
    private func recastRequestDone(_ response : Response)
    {
        print("RECAST: Done")
        if let intentSlug = response.intent()?.slug {
            if intentSlug == "weather" {
                if let location = response.get(entity: "location") {
                    if let latitude = location["lat"] as? Double , let longitude = location["lng"] as? Double {
                        //self.getForecast(latitude: latitude, logitude: longitude)
                        client.getForecast(latitude: latitude, longitude: longitude, time: Date()) { result in
                            switch result
                            {
                            case .success(let forecast):
                                print(forecast.0.currently!.summary!)
                                
                                DispatchQueue.main.async
                                    {
                                        self.myLabel.text = forecast.0.currently!.summary!
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    } else {
                        self.myLabel.text = "Place doesn't exist"
                    }
                } else {
                    self.myLabel.text = "Place doesn't exist"
                }
            } else {
                self.myLabel.text = "Can't process input information"
            }
        } else {
            self.myLabel.text = "Can't perform request at a memont"
        }
    }
    

    func recastRequestNotDone(_ error : Error)
    {
        print(error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

