//
//  ViewController.swift
//  Big Timer TV
//
//  Created by Joel Klabo on 5/27/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let timeFormatter = TimeFormatter(separator: ":")
    
    @IBOutlet weak var timeLabel: TimeLabel!
    @IBOutlet weak var arrow: Arrow!
    @IBOutlet weak var clockView: ClockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrow.lineColor = UIColor.white
        arrow.lineWidth = Theme.tvLineWidth
        
        clockView.lineWidth = Theme.tvLineWidth
        
        TimerController.instance.delegate = self
        
        let playPauseRecognizer = UITapGestureRecognizer(target: self, action: #selector(playPausePressed))
        playPauseRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue)]
        view.addGestureRecognizer(playPauseRecognizer)
        
        let clickRecognizer = UITapGestureRecognizer(target: self, action: #selector(playPausePressed))
        view.addGestureRecognizer(clickRecognizer)
        
        let menuButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(menuButtonPressed))
        menuButtonRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        view.addGestureRecognizer(menuButtonRecognizer)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(sender:))))
    }
    
    @objc func menuButtonPressed() {
        TimerController.instance.clear()
    }
    
    @objc func playPausePressed() {
        TimerController.instance.toggle()
    }

}

extension ViewController: TimerManagerDelegate {

    func timerUpdate(timerState: TimerState) {
        clockView.rotateToTime(time: timerState.timerValue)
        let formattedTime = timeFormatter.formatTime(timerState.timerValue)
        timeLabel.text = formattedTime.formattedString
        arrow.changeDirection(direction: timerState.direction)
    }
    
    func timerDone() {
        AudioController.instance.playSound()
    }
}

extension ViewController: PanGestureInfoReceiving {
    @objc func verticalPanPassthrough(sender: AnyObject) {
        verticalPan(sender: sender)
    }
    func verticalPanInfo(velocity: CGFloat, translation: CGFloat) {
        TimerController.instance.setTimerToDirection(direction: .Down)
        TimerController.instance.modifyTime(time: TimeDeltaCalculator.timeDeltaFrom(velocity: velocity, translation: translation))
    }
}
