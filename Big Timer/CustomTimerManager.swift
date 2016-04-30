//
//  CustomTimerManager.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/25/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct CustomTimerManager {
    
    private let timersKey = "CustomTimers"
    private let plistDictionary = PlistReader(fileName: "CustomTimers").readPlist()
    
    func getTimers() -> Array<CustomTimer> {
        
        guard let arrayOfTimes = plistDictionary[timersKey] as? Array<AnyObject> else {
            fatalError()
        }
        
        var timers: [CustomTimer] = []
        for (index, time) in arrayOfTimes.enumerate() {
            guard let time = Int(time as! String) else {
                fatalError()
            }
            timers.append(CustomTimer(index: index, time: time))
        }
        
        return timers
    }
}

enum CustomTimer {

    case First(time: Int)
    case Second(time: Int)
    case Third(time: Int)
    
    init(index: Int, time: Int) {
        switch index {
        case 0:
            self = .First(time: time)
        case 1:
            self = .Second(time: time)
        case 2:
            self = .Third(time: time)
        default:
            fatalError()
        }
    }
    
    func uniqueKey() -> String {
        switch self {
        case .First:
            return "firstCustomTimer"
        case .Second:
            return "secondCustomTimer"
        case .Third:
            return "thirdCustomTimer"
        }
    }
    
    func title() -> String {
        switch self {
        case .First(let time):
            return TimeFormatter().formatTime(time)
        case .Second(let time):
            return TimeFormatter().formatTime(time)
        case .Third(let time):
            return TimeFormatter().formatTime(time)
        }
    }
    
}