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
    var previousNumber:Double = 0;
    var mathOperation = false;
    var operation = 0;
    var result:Double = 0;
    @IBOutlet weak var display: UILabel!
    
    /* The number keypad in one function */
    @IBAction func numbers(_ sender: UIButton)
    {
        if display.text == "0" || result > 0
        {
            display.text = ""
            display.text = display.text! + String(sender.tag-1)
        }
        else
        {
            if mathOperation == true
            {
                display.text = String(sender.tag - 1)
                numberOnScreen = Double(display.text!)!
                mathOperation = false;
            }
            else
            {
                display.text = display.text! + String(sender.tag-1)
            }
        }
        numberOnScreen = Double(display.text!)!
    }
    
    /* The function keypad in one function */
    @IBAction func functionButtons(_ sender: UIButton)
    {
        if sender.tag != 11 && sender.tag != 16
        {
            previousNumber = Double(display.text!)!
            
            if sender.tag == 12 /* Addition */
            {
                display.text = "+"
            }
            else if sender.tag == 13 /* Subtraction */
            {
                display.text = "-"
            }
            else if sender.tag == 14 /* Multiplication */
            {
                display.text = "x"
            }
            else if sender.tag == 15 /* Division */
            {
                display.text = "/"
            }
            
            operation = sender.tag;
            mathOperation = true;
        }
        else if sender.tag == 16 /* Equal Sign */
        {
            if operation == 12 /* Addition */
            {
                display.text = String(previousNumber + numberOnScreen)
                result = Double(previousNumber + numberOnScreen)
            }
            else if operation == 13 /* Subtraction */
            {
                display.text = String(previousNumber - numberOnScreen)
                result = Double(previousNumber - numberOnScreen)
            }
            else if operation == 14 /* Multiplication */
            {
                display.text = String(previousNumber * numberOnScreen)
                result = Double(previousNumber * numberOnScreen)
            }
            else if operation == 15 /* Division */
            {
                display.text = String(previousNumber / numberOnScreen)
                result = Double(previousNumber / numberOnScreen)
            }
        }
        else if sender.tag == 11  /* Clearing the data on and off screen */
        {
            display.text = "0"
            numberOnScreen = 0;
            previousNumber = 0;
            operation = 0;
            mathOperation = false;
        }
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

