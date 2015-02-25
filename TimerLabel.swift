//
//  TimerLabel.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/24/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class TimerLabel: UILabel {

    let timeFormatter = TimeFormatter()
    
    func setTime (time: Time) {
        if (time >= 0) {
            self.text = timeFormatter.formatTime(time)
        } else {
            self.text = timeFormatter.formatTime(0)
        }
    }

}
