//
//  SecondViewController.swift
//  Day05 - Kanto
//
//  Created by Khomotjo MODIPA on 2018/10/08.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    /* Return number of places to display */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Places.places_tuble.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* getting the cell to work with */
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellIdentifier")
        /* Don't forget we are working with one row at a time */
        cell?.textLabel?.text = Places.places_tuble[indexPath.row].0
        
        return cell!
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

