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
        self.view.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Set the Center of the Circle
            // 1
            let circleCenter = touch.location(in: view)
            
            // Set a random Circle Radius
            // 2
            let circleWidth = CGFloat(25 + (arc4random() % 50))
            let circleHeight = circleWidth
            
            // Create a new CircleView
            // 3
            let circleView = Shape(frame: CGRect(x: circleCenter.x, y: circleCenter.y, width: circleWidth, height: circleHeight))
            view.addSubview(circleView)
        }
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

