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
    
    lazy var timerController = TimerController()
    lazy var audioController = AudioController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerController.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.enteringBackground), name: UIApplicationWillResignActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.returningFromBackground), name: UIApplicationWillEnterForegroundNotification, object: nil)
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

    @IBAction func verticalPan(sender: AnyObject) {
        let gestureRecognizer = sender as! UIPanGestureRecognizer
        let velocity = -gestureRecognizer.velocityInView(self.view).y
        let translation = -gestureRecognizer.translationInView(self.view).y
        
        timerController.setTimerToDirection(.Down)
        timerController.modifyTime(timeDeltaFrom(velocity, translation: translation))
    }
    
    private func timeDeltaFrom(velocity: CGFloat, translation: CGFloat) -> CFTimeInterval {
        var velocityMultiplier = abs(velocity / 600)
        var modifiedTranslation = translation
        if (translation > 0) {
            // Positive translation
            if (translation < 1) {
                // It's between zero and one, bump it up to one
                modifiedTranslation = 1
                velocityMultiplier = velocityMultiplier * 100
            }
        } else {
            // Negative translation
            if (translation > -1) {
                // It's between negative one and zero, move it to negative one
                modifiedTranslation = -1
            }
        }
        // If both values are less than zero fake a 1 so we can get off the ground
        let product = modifiedTranslation * velocityMultiplier
        print("velocity multiplier: \(velocityMultiplier)")
        print("translation: \(modifiedTranslation)")
        print("product: \(product)")
        return CFTimeInterval(product)
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
