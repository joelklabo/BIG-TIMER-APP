//
//  TimerValue.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct TimerValue {
    
    var time: CFTimeInterval = 0
    
    mutating func update(timeDelta: CFTimeInterval) {
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