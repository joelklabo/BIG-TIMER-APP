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
    
    lazy var audioController = AudioController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.enteringBackground), name: UIApplicationWillResignActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.returningFromBackground), name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        TimerController.instance.delegate = self
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(_:))))

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
        TimerController.instance.returningFromBackground()
    }
    
    func enteringBackground () {
        TimerController.instance.enteringBackground()
    }

    @IBAction func tap(sender: AnyObject) {
        TimerController.instance.toggle()
    }

    @IBAction func clear(sender: AnyObject) {
        TimerController.instance.clear()
    }

    @IBAction func arrowTap(sender: AnyObject) {
        TimerController.instance.changeTimerDirection()
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
    func verticalPanPassthrough(sender: AnyObject) {
        verticalPan(sender)
    }
    func verticalPanInfo(velocity: CGFloat, translation: CGFloat) {
        TimerController.instance.setTimerToDirection(.Down)
        TimerController.instance.modifyTime(TimeDeltaCalculator.timeDeltaFrom(velocity, translation: translation))
    }
}
