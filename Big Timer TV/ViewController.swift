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
        arrow.lineWidth = Theme.tvLineWidth()
        
        clockView.lineWidth = Theme.tvLineWidth()
        
        TimerController.instance.delegate = self
        
        let playPauseRecognizer = UITapGestureRecognizer(target: self, action: #selector(playPausePressed))
        playPauseRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.playPause.rawValue as Int)]
        view.addGestureRecognizer(playPauseRecognizer)
        
        let clickRecognizer = UITapGestureRecognizer(target: self, action: #selector(playPausePressed))
        view.addGestureRecognizer(clickRecognizer)
        
        let menuButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(menuButtonPressed))
        menuButtonRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue as Int)]
        view.addGestureRecognizer(menuButtonRecognizer)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(_:))))
        
    }
    
    func menuButtonPressed() {
        TimerController.instance.clear()
    }
    
    func playPausePressed() {
        TimerController.instance.toggleTimer()
    }

}

extension ViewController: TimerManagerDelegate {
    internal func timerUpdate(encodedTimerState: EncodableTimerState) {
        guard let state = encodedTimerState.state else {
            return
        }
        clockView.rotateToTime(state.timerValue)
        let formattedTime = timeFormatter.formatTime(time: state.timerValue)
        timeLabel.text = formattedTime.formattedString
        arrow.changeDirection(state.direction)
    }

    func timerDone() {
        AudioController.instance.playSound()
    }
}

extension ViewController: PanGestureInfoReceiving {
    func verticalPanPassthrough(_ sender: AnyObject) {
        verticalPan(sender)
    }
    func verticalPanInfo(_ velocity: CGFloat, translation: CGFloat) {
        TimerController.instance.update(direction: .down)
        TimerController.instance.adjust(byTime: TimeDeltaCalculator.timeDeltaFrom(velocity, translation: translation))
            
    }
}
