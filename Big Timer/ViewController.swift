//
//  ViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ClockUpdateDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet var singleTapRecognizer: UITapGestureRecognizer!
    @IBOutlet var doubleTapRecognizer: UITapGestureRecognizer!
    
    let clock = Clock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clock.delegate = self
    }
    
    func clockUpdate(timeState: TimeState, clockState: ClockState) {
        self.timeLabel?.text = formatTimeState(timeState)
        self.statusLabel?.text = formatClockState(clockState)
    }
    
    func formatClockState(state: ClockState) -> String {
        switch (state) {
        case .Paused:
            return "Paused"
        case .Running:
            return "Running"
        case .Cleared:
            return "Ready"
        default:
            return ""
        }
    }
    
    func formatTimeState(time: TimeState) -> String {
        switch time {
        case (0, 0, _):
            return "\(time.seconds)"
        case (0, _, _):
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

    
    @IBAction func singleTap(sender: AnyObject) {
        switch (clock.currentState()) {
        case .Cleared, .Paused:
            clock.start()
        case .Running:
            clock.pause()
        }
    }
    @IBAction func doubleTap(sender: AnyObject) {
        clock.clear()
    }

}

