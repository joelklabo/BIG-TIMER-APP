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
    
    var timeStamp:  Date
    var timerValue: Double
    var direction:  TimerDirection
    var isRunning:  Bool
    
    static func zeroState() -> TimerState {
        return TimerState(timeStamp: Date(), timerValue: 0, direction: .up, isRunning: false)
    }
    
    func update(timerValue: Double) -> TimerState {
        return TimerState(timeStamp: self.timeStamp, timerValue: timerValue, direction: self.direction, isRunning: self.isRunning)
    }

    func update(direction: TimerDirection) -> TimerState {
        return TimerState(timeStamp: self.timeStamp, timerValue: self.timerValue, direction: direction, isRunning: self.isRunning)
    }

    func update(isRunning: Bool) -> TimerState {
        return TimerState(timeStamp: self.timeStamp, timerValue: self.timerValue, direction: direction, isRunning: isRunning)
    }
    
    func adjust(byTime time: Double) -> TimerState {
        return TimerState(timeStamp: self.timeStamp, timerValue: self.timerValue + time, direction: self.direction, isRunning: self.isRunning)
    }
    
}
