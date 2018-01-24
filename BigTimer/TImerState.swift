//
//  TImerState.swift
//  BigTimer
//
//  Created by Joel Klabo on 3/23/17.
//  Copyright © 2017 Joel Klabo. All rights reserved.
//

import Foundation



struct TimerState {
    
    enum Direction {
        case up
        case down
    }
    
    var running: Bool
    var value: Double
    var timestamp: Double
    var direction: ArrowView.Direction
    
    mutating func update(_ timestamp: Double) {
        let timeElapsed = timestamp - self.timestamp
        self.timestamp = timestamp
        if self.running {
            if direction == .up {
                self.value += timeElapsed
            } else {
                self.value -= timeElapsed
            }
        }
    }
}

extension TimerState {
    init() {
        self = TimerState.init(running: false,
                               value: 0,
                               timestamp: 0,
                               direction: .up)
    }
}
