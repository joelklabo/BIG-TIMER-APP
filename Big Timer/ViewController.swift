//
//  ViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TimerUpdateDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet var singleTapRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var clockView: ClockView!
    
    let timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.delegate = self
    }
    
    func formatTime(time: Time) -> String {
        switch time {
        case (0, 0, _, _):
            return "\(time.seconds)"
        case (0, _, _, _):
            return "\(time.minutes):\(padNumber(time.seconds))"
        default:
            return "\(time.hours):\(padNumber(time.minutes)):\(padNumber(time.seconds))"
        }
    }
    
    func padNumber(number: Int) -> String {
        if (number < 10) {
            return "0\(number)"
        } else {
            return "\(number)"
        }
    }
    
    @IBAction func tap(sender: AnyObject) {
        timer.toggle()
    }
    
    
    @IBAction func swipe(sender: AnyObject) {
        timer.reset()
        clockView.reset()
    }

    // Timer Update Delegate
    
    func timeUpdate(time: Time) {
        timeLabel?.text = formatTime(time)
    }
    
    func tick(timeDelta: Double) {
        clockView.rotate(timeDelta)
    }


}

