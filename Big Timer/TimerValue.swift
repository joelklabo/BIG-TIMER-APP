//
//  TimerValue.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct TimerValue {
    
    var time: Double = 0
    
    mutating func update(_ timeDelta: Double) {
        if timeDelta > 0 {
            time = time + timeDelta
        } else {
            if (time + timeDelta) < 0 {
                time = 0
            } else {
                time = time + timeDelta
            }
        }
    }
    
}
