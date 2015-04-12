//
//  ViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TimerManagerDelegate {

    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var arrowView: Arrow!
    
    let timerController = TimerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerController.subscribeToTimerUpdates(self)
    }

    @IBAction func verticalPan(sender: AnyObject) {
        let gestureRecognizer = sender as! UIPanGestureRecognizer
        let velocity = gestureRecognizer.velocityInView(self.view)
        let time = round(Double(-velocity.y / 400))
        timerController.modifyTime(time)
    }

    @IBAction func tap(sender: AnyObject) {
        timerController.toggle()
    }

    @IBAction func clear(sender: AnyObject) {
        timerController.clear()
    }

    @IBAction func arrowTap(sender: AnyObject) {
        timerController.changeTimerDirection()
    }

    // Timer Update Delegate

    func timerUpdate(timerState: TimerState) {
        clockView.rotateToTime(timerState.timerValue)
        timeLabel.text = TimeFormatter().formatTime(timerState.timerValue)
        arrowView.changeDirection(timerState.direction)
    }

}
