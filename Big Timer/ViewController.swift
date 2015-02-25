//
//  ViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TimerUpdateDelegate {
    
    @IBOutlet weak var timeLabel: TimerLabel!

    @IBOutlet var singleTapRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var clockView: ClockView!
    
    var time: Double = 0
    
    let timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.delegate = self
        timeLabel.setTime(1000)
    }
    
    @IBAction func verticalPan(sender: AnyObject) {
        let gestureRecognizer = sender as UIPanGestureRecognizer
        let velocity = gestureRecognizer.velocityInView(self.view)
        let time = round(Double(-velocity.y / 400))
        timeLabel.setTime(time)
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
    }

}

