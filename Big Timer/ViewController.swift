//
//  ViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TimerUpdateDelegate {
    
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var timeLabel: UILabel!
        
    let timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.delegate = self
    }
    
    @IBAction func verticalPan(sender: AnyObject) {
        let gestureRecognizer = sender as UIPanGestureRecognizer
        let velocity = gestureRecognizer.velocityInView(self.view)
        let time = round(Double(-velocity.y / 400))
    }
    
    @IBAction func tap(sender: AnyObject) {
        timer.toggle()
    }

    @IBAction func clear(sender: AnyObject) {
        timer.reset()
        clockView.reset()
    }
    
    // Timer Update Delegate
    
    func tick(time: Time) {
        clockView.rotate(time)
        timeLabel.text = "\(time * 1000)"
    }

}

