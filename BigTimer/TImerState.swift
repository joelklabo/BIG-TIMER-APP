//
//  TImerState.swift
//  BigTimer
//
//  Created by Joel Klabo on 3/23/17.
//  Copyright © 2017 Joel Klabo. All rights reserved.
//

import Foundation



public struct TimerState {
    
    enum Direction {
        case up
        case down
    }
    
    var value: Double = 0
    var running: Bool = false
    var direction: Direction = .up
    
    private var timestamp: Double = 0
    
    mutating func update(_ timestamp: Double) {
        let timeElapsed = timestamp - self.timestamp
        self.timestamp = timestamp
        if self.running {
            if direction == .up {
                self.value += timeElapsed
            } else {
                self.value -= timeElapsed
            }
            print(self.value)
        }
    }
}
