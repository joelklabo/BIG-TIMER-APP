//
//  TimeFormatter.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/24/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

typealias TimeComponents = (hours: Int, minutes: Int, seconds: Int)
typealias TimeDisplaySections = Int
typealias FormattedTime = (formattedString: String, timeSections: TimeDisplaySections)

struct TimeFormatter {
    
    let separator: String
    
    func formatTime(_ time: CFTimeInterval) -> FormattedTime {
        return buildFormattedTime(buildTimeState(time))
    }
    
    func formatTime(_ time: Int) -> FormattedTime {
        return formatTime(CFTimeInterval(time))
    }
    
    fileprivate func buildTimeState(_ time: CFTimeInterval) -> TimeComponents {
        
        let hours   = Int(floor(time / 3600))
        let minutes = Int(floor((time / 60).truncatingRemainder(dividingBy: 60)))
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        
        return (hours: hours, minutes: minutes, seconds: seconds)
    }

    fileprivate func buildFormattedTime(_ time: TimeComponents) -> FormattedTime {
        var timeComponents: [String] = []
        var displaySections = 0
        switch time {
        case (0, 0, _):
            displaySections = 1
            timeComponents.append("\(time.seconds)")
            break
        case (0, _, _):
            displaySections = 2
            timeComponents.append("\(time.minutes)")
            timeComponents.append("\(padNumber(time.seconds))")
            break
        default:
            displaySections = 3
            timeComponents.append("\(time.hours)")
            timeComponents.append("\(padNumber(time.minutes))")
            timeComponents.append("\(padNumber(time.seconds))")
            break
        }
        return (timeComponents.joined(separator: separator), displaySections)
    }
    
    
    fileprivate func padNumber(_ number: Int) -> String {
        if (number < 10) {
            return "0\(number)"
        } else {
            return "\(number)"
        }
    }
    
}
