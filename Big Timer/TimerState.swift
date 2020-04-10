//
//  TimeArchive.swift
//  Big Timer
//
//  Created by Joel Klabo on 3/25/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

struct TimerState: Codable, Equatable {

    var timeStamp: Date
    var timerValue: Double
    var direction: TimerDirection
    var isRunning: Bool
    
    static func newState(timerValue: Int, direction: TimerDirection, isRunning: Bool) -> TimerState {
        return TimerState.newState(timerValue: Double(timerValue), direction: direction, isRunning: isRunning)
    }
    
    static func newState(timerValue: Double, direction: TimerDirection, isRunning: Bool) -> TimerState {
        return TimerState(timeStamp: Date(), timerValue: timerValue, direction: direction, isRunning: isRunning)
    }
    
    static var zero: TimerState {
        return TimerState.newState(timerValue: 0, direction: .Up, isRunning: false)
    }
}

enum TimerDirection: String, Codable, Equatable {
    case Up
    case Down
}
