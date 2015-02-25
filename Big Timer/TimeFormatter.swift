//
//  TimeFormatter.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/24/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

typealias TimeState = (hours: Int, minutes: Int, seconds: Int)

class TimeFormatter {
    
    func formatTime (time: Time) -> String {
        return buildString(buildTimeState(time))
    }
    
    private func buildTimeState(time: Time) -> TimeState {
        
        var timeState: TimeState
        
        let time = round(time)
        
        let hours = Int(floor(time / 3600))
        let minutes = Int(floor((time / 60) % 60))
        let seconds = Int(time % 60)
        
        return (hours: hours, minutes: minutes, seconds: seconds)
        
    }

    private func buildString(time: TimeState) -> String {
        switch time {
        case (0, 0, _):
            return "\(time.seconds)"
        case (0, _, _):
            return "\(time.minutes):\(padNumber(time.seconds))"
        default:
            return "\(time.hours):\(padNumber(time.minutes)):\(padNumber(time.seconds))"
        }
    }
    
    private func padNumber(number: Int) -> String {
        if (number < 10) {
            return "0\(number)"
        } else {
            return "\(number)"
        }
    }
    
}