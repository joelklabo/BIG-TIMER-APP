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
    
    let timerController = TimerController()
            
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let sceneCount = UIApplication.shared.sceneCount
        view.backgroundColor = Theme.mainAppColor(sceneNumber: sceneCount)
        
        if UIApplication.shared.isTesting {
            let time: TimeInterval = 581
            let formattedTime = timeFormatter.formatTime(time)
            timeLabel.text = formattedTime.formattedString
            clockView.rotateToTime(time: time)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.enteringBackground), name: UIScene.willDeactivateNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.enteringForeground), name: UIScene.didActivateNotification, object: nil)
        }
        
        timerController.delegate = self
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(sender:))))
    }

    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func enteringForeground () {
        #if targetEnvironment(macCatalyst)
        return
        #else
        timerController.enteringForeground()
        #endif
    }
    
    @objc func enteringBackground () {
        #if targetEnvironment(macCatalyst)
        return
        #else
            timerController.enteringBackground()
        #endif
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
        timerController.setTimerToDirection(direction: .Down)
        timerController.modifyTime(time: TimeDeltaCalculator.timeDeltaFrom(velocity: velocity, translation: translation))
    }
}
