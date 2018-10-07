//
//  ViewController.swift
//  Rush00-42Forum
//
//  Created by Khomotjo MODIPA on 2018/10/07.
//  Copyright © 2018 Khomotjo MODIPA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func _post(_ sender: UIButton) {
        
        let UID = "2478bbe3602f3c04b8966893d58cb39c24c0a862ed4a0e556e5e55e7a6246c32"
        let SECRET = "343a60d286731fbf19013b05663665c1f1edc57ba05c3191349d0f2b580113d0"
        let BEARER = ((UID + ":" + SECRET).data(using: String.Encoding.utf8, allowLossyConversion: true))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        
        guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {return}
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
//            guard let _:Data = data else {
//                return
//            }
//
//            let json:Any?
//            do {
//                json = try JSONSerialization.jsonObject(with: data!, options: [])
//            }
//            catch {
//                return
//            }
        })
        
        task.resume()
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: <#T##Any#>, options: <#T##JSONSerialization.WritingOptions#>)
    }
    
    @IBAction func _get(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

