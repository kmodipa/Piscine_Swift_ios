//
//  ViewController.swift
//  ex03
//
//  Created by Khomotjo MODIPA on 2018/10/01.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBAction func numbers(_ sender: UIButton) {
        display.text = String(sender.tag-1)
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

