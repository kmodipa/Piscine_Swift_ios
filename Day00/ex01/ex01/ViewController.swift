//
//  ViewController.swift
//  ex01
//
//  Created by Khomotjo MODIPA on 2018/10/01.
//  Copyright © 2018 Khomotjo Modipa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HelloWorld: UILabel!
    @IBAction func Button(_ sender: UIButton) {
        HelloWorld.text = "Hello World"
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

