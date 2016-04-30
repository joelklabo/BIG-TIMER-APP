//
//  CustomTimerViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/26/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

class CustomTimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: TimeLabel?
    
    let timeFormatter = TimeFormatter()
    
    var timerValue = TimerValue() {
        didSet {
            if let timeLabel = timeLabel {
                timeLabel.text = timeFormatter.formatTime(timerValue.time)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel!.panInfoDelegate = self
        timeLabel!.text = timeFormatter.formatTime(timerValue.time)
    }

}

extension CustomTimerViewController: PanGestureInfoReceiving {
    func verticalPanInfo(velocity: CGFloat, translation: CGFloat) {
        let timeDelta = TimeDeltaCalculator.timeDeltaFrom(velocity, translation: translation)
        print(timeDelta)
        timerValue.update(timeDelta)
    }
}
