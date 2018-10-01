//
//  ViewController.swift
//  ex03
//
//  Created by Khomotjo MODIPA on 2018/10/01.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen:Double = 0;
    @IBOutlet weak var display: UILabel!
    
    /* The number keypad in one function */
    @IBAction func numbers(_ sender: UIButton)
    {
        if display.text == "0"
        {
            display.text = ""
            display.text = display.text! + String(sender.tag-1)
        }
        else
        {
            display.text = display.text! + String(sender.tag-1)
        }
        numberOnScreen = Double(display.text!)!
    }
    
    /* The function keypad in one function */
    @IBAction func functionButtons(_ sender: UIButton)
    {
        
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

