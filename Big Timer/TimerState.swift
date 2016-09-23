//
//  TimeArchive.swift
//  Big Timer
//
//  Created by Joel Klabo on 3/25/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

enum TimerDirection: String {
    case up
    case down
}

struct TimerState {
    
    var timeStamp: Date
    var timerValue: CFTimeInterval
    var direction: TimerDirection
    var isRunning: Bool
    
    static func zeroState() -> TimerState {
        return TimerState(timeStamp: Date(), timerValue: 0, direction: .up, isRunning: false)
    }
}
