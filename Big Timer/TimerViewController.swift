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
        
    override func viewDidLoad() {
        
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.enteringBackground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.returningFromBackground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        TimerController.instance.delegate = self
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(sender:))))
        
        if UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT") {
            let time: TimeInterval = 581
            let formattedTime = timeFormatter.formatTime(time)
            timeLabel.text = formattedTime.formattedString
            clockView.rotateToTime(time: time)
        }
    }
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func returningFromBackground () {
        TimerController.instance.returningFromBackground()
    }
    
    @objc func enteringBackground () {
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
        settingsNavigationController.modalTransitionStyle = .crossDissolve
        self.present(settingsNavigationController, animated: true, completion: nil)
    }
    
    // Timer Update Delegate

    func timerUpdate(timerState: TimerState) {
        clockView.rotateToTime(time: timerState.timerValue)
        let formattedTime = timeFormatter.formatTime(timerState.timerValue)
        timeLabel.text = formattedTime.formattedString
        arrowView.changeDirection(direction: timerState.direction)
    }
    
    func timerDone () {
        AudioController.instance.playSound()
    }

}

extension TimerViewController: PanGestureInfoReceiving {
    @objc func verticalPanPassthrough(sender: AnyObject) {
        verticalPan(sender: sender)
    }
    func verticalPanInfo(velocity: Double, translation: Double) {
        TimerController.instance.setTimerToDirection(direction: .Down)
        TimerController.instance.modifyTime(time: TimeDeltaCalculator.timeDeltaFrom(velocity: velocity, translation: translation))
    }
}
