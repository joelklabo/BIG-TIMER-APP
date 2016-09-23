//
//  ViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, TimerManagerDelegate {

    let timeFormatter = TimeFormatter(separator: ":")
    
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var timeLabel: TimeLabel!
    @IBOutlet weak var arrowView: Arrow!
    
    @IBOutlet weak var timerLabelButton: UIButton!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.enteringBackground), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.returningFromBackground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        TimerController.instance.delegate = self
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(_:))))
        
        if UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT") {
            let time: TimeInterval = 581
            let formattedTime = timeFormatter.formatTime(time)
            timeLabel.text = formattedTime.formattedString
            clockView.rotateToTime(time)
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func returningFromBackground () {
        TimerController.instance.returningFromBackground()
    }
    
    func enteringBackground () {
        TimerController.instance.enteringBackground()
    }

    @IBAction func timerLabelPressed(_ sender: AnyObject) {
        
    }
    
    @IBAction func tap(_ sender: AnyObject) {
        TimerController.instance.toggle()
    }

    @IBAction func clear(_ sender: AnyObject) {
        TimerController.instance.clear()
    }

    @IBAction func arrowTap(_ sender: AnyObject) {
        TimerController.instance.changeTimerDirection()
    }

    @IBAction func settingsTap(_ sender: AnyObject) {
        let settingsNavigationController = UINavigationController(rootViewController: SettingsViewController())
        settingsNavigationController.modalTransitionStyle = .crossDissolve
        self.present(settingsNavigationController, animated: true, completion: nil)
    }
    
    // Timer Update Delegate

    func timerUpdate(_ timerState: TimerState) {
        clockView.rotateToTime(timerState.timerValue)
        let formattedTime = timeFormatter.formatTime(timerState.timerValue)
        timeLabel.text = formattedTime.formattedString
        arrowView.changeDirection(timerState.direction)
        updateTimerLabelOpacity(timerState.isRunning)
    }
    
    func timerDone () {
        AudioController.instance.playSound()
    }
    
    func updateTimerLabelOpacity(_ timerIsRunning: Bool) {
        if timerIsRunning {
            timerLabelButton.alpha = CGFloat(0.4)
        } else {
            timerLabelButton.alpha = CGFloat(1.0)
        }
        timerLabelButton.isEnabled = !timerIsRunning
    }

}

extension TimerViewController: PanGestureInfoReceiving {
    func verticalPanPassthrough(_ sender: AnyObject) {
        verticalPan(sender)
    }
    func verticalPanInfo(_ velocity: CGFloat, translation: CGFloat) {
        TimerController.instance.setTimerToDirection(.Down)
        TimerController.instance.modifyTime(TimeDeltaCalculator.timeDeltaFrom(velocity, translation: translation))
    }
}
