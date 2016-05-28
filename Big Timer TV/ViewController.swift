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
    @IBOutlet weak var clearButton: ClearButton!
    @IBOutlet weak var arrow: Arrow!
    @IBOutlet weak var clockView: ClockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearButton.lineColor = UIColor.whiteColor()
        clearButton.lineWidth = Theme.tvLineWidth()
        
        arrow.lineColor = UIColor.whiteColor()
        arrow.lineWidth = Theme.tvLineWidth()
        
        clockView.lineWidth = Theme.tvLineWidth()
        
        TimerController.instance.delegate = self
        
        let playPauseRecognizer = UITapGestureRecognizer(target: self, action: #selector(playPausePressed))
        playPauseRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)]
        view.addGestureRecognizer(playPauseRecognizer)
        
        let menuButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(menuButtonPressed))
        menuButtonRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Menu.rawValue)]
        view.addGestureRecognizer(menuButtonRecognizer)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(_:))))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menuButtonPressed() {
        TimerController.instance.clear()
    }
    
    func playPausePressed() {
        TimerController.instance.toggle()
    }

}

extension ViewController: TimerManagerDelegate {

    func timerUpdate(timerState: TimerState) {
        clockView.rotateToTime(timerState.timerValue)
        let formattedTime = timeFormatter.formatTime(timerState.timerValue)
        timeLabel.text = formattedTime.formattedString
        arrow.changeDirection(timerState.direction)
    }
    
    func timerDone() {
        AudioController.instance.playSound()
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
