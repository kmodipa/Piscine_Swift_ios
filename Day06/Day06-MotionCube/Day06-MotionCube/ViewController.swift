//
//  ViewController.swift
//  Day06-MotionCube
//
//  Created by Khomotjo MODIPA on 2018/10/09.
//  Copyright © 2018 Khomotjo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let Gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(gesture:)))
        view.addGestureRecognizer(Gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        print("Tapped")
    }
    
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("Began")
        case .changed:
            print("Changed to \(gesture.location(in: view))")
        case .ended:
            print("Ended")
        case .failed:
            print("Failed or Cancelled")
       case .possible:
            print("Possible")
        default:
            print("Trying to be exhaustive")
        }
    }
}

