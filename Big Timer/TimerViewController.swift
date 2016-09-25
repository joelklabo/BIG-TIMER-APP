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

        colorChangeDidOccur()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.enteringBackground), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.returningFromBackground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.colorChangeDidOccur), name: ColorSettingController().colorChangeNotificationKey, object: nil)
        
        TimerController.instance.delegate = self
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(_:))))
        
        if UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT") {
            let time: Double = 581
            let formattedTime = timeFormatter.formatTime(time: time)
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

    @IBAction func tap(_ sender: AnyObject) {
        TimerController.instance.toggleTimer()
    }
    
    @IBAction func clear(_ sender: AnyObject) {
        TimerController.instance.clear()
    }

    @IBAction func arrowTap(_ sender: AnyObject) {
        TimerController.instance.toggleDirection()
    }

    @IBAction func settingsTap(_ sender: AnyObject) {
        let settingsNavigationController = UINavigationController(rootViewController: SettingsViewController())
        settingsNavigationController.modalTransitionStyle = .crossDissolve
        self.present(settingsNavigationController, animated: true, completion: nil)
    }

    // Timer Update Delegate

    func timerUpdate(encodedTimerState: EncodableTimerState) {
        guard let state = encodedTimerState.state else { return }
        clockView.rotateToTime(state.timerValue)
        let formattedTime = timeFormatter.formatTime(time: state.timerValue)
        timeLabel.text = formattedTime.formattedString
        arrowView.changeDirection(state.direction)
    }
    
    func timerDone () {
        AudioController.instance.playSound()
    }

}

extension TimerViewController: ColorChangeDelegate {
    func colorChangeDidOccur() {
        self.view.backgroundColor = ColorSettingController().selectedColor()
    }
}

extension TimerViewController: PanGestureInfoReceiving {
    func verticalPanPassthrough(_ sender: AnyObject) {
        verticalPan(sender)
    }
    func verticalPanInfo(_ velocity: CGFloat, translation: CGFloat) {
        TimerController.instance.update(direction: .down)
        TimerController.instance.adjust(byTime: TimeDeltaCalculator.timeDeltaFrom(velocity, translation: translation))
    }
}
