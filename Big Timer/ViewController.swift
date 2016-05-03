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
    @IBOutlet weak var timeLabel: TimeLabel!
    @IBOutlet weak var arrowView: Arrow!
    
    lazy var timerController = TimerController()
    lazy var audioController = AudioController()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.enteringBackground), name: UIApplicationWillResignActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.returningFromBackground), name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        timerController.delegate = self
        timeLabel.panInfoDelegate = self
        
        if NSUserDefaults.standardUserDefaults().boolForKey("FASTLANE_SNAPSHOT") {
            let time: NSTimeInterval = 581
            timeLabel.text = TimeFormatter().formatTime(time)
            clockView.rotateToTime(time)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func returningFromBackground () {
        timerController.returningFromBackground()
    }
    
    func enteringBackground () {
        timerController.enteringBackground()
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

    @IBAction func settingsTap(sender: AnyObject) {
        let settingsNavigationController = UINavigationController(rootViewController: SettingsViewController())
        settingsNavigationController.modalTransitionStyle = .CrossDissolve
        self.presentViewController(settingsNavigationController, animated: true, completion: nil)
    }
    
    // Timer Update Delegate

    func timerUpdate(timerState: TimerState) {
        clockView.rotateToTime(timerState.timerValue)
        timeLabel.text = TimeFormatter().formatTime(timerState.timerValue)
        arrowView.changeDirection(timerState.direction)
    }
    
    func timerDone () {
        audioController = AudioController(alertSound: AlertSound.getPreference())
        audioController.playSound()
    }

}

extension ViewController: PanGestureInfoReceiving {
    func verticalPanInfo(velocity: CGFloat, translation: CGFloat) {
        timerController.setTimerToDirection(.Down)
        timerController.modifyTime(TimeDeltaCalculator.timeDeltaFrom(velocity, translation: translation))
    }
}
