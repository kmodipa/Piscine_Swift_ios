//
//  ViewController.swift
//  ex00
//
//  Created by Khomotjo MODIPA on 2018/10/04.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    /* Returns the number of items from our data source */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.films.count
    }
    
    /* Returns the data we use to populate our tableView */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathCell")
        cell?.textLabel?.text = Data.films[indexPath.row].0 /* Giving our textLabel some info */
        cell?.detailTextLabel?.text = String(Data.films[indexPath.row].1)
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

