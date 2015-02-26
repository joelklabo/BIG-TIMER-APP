//
//  ViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TimerControllerDelegate {
    
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var timeLabel: UILabel!
        
    let timerController = TimerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerController.delegate = self
    }
    
    @IBAction func verticalPan(sender: AnyObject) {
        let gestureRecognizer = sender as UIPanGestureRecognizer
        let velocity = gestureRecognizer.velocityInView(self.view)
        let time = round(Double(-velocity.y / 400))
    }
    
    @IBAction func tap(sender: AnyObject) {
        timerController.toggleCountingUp()
    }

    @IBAction func clear(sender: AnyObject) {
        clockView.reset()
        timerController.clear()
    }
    
    // Timer Update Delegate
    
    func tick(timeDelta: Time, totalTime: Time) {
        clockView.rotate(timeDelta)
        timeLabel.text = TimeFormatter().formatTime(totalTime)
    }

}

