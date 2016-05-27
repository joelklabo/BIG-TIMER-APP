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
        
        TimerController.instance.toggle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
