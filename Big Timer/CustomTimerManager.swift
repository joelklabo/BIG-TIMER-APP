//
//  CustomTimerManager.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/25/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

struct CustomTimerManager {
    
    fileprivate let timersKey = "CustomTimers"
    fileprivate let plistReader = PlistReader()
    
    func updateTimer(_ timer: CustomTimer, newValue: Double) {
        var timers = getTimers()
        switch timer {
        case .first:
            timers[timer.index()] = .first(time: newValue)
        case .second:
            timers[timer.index()] = .second(time: newValue)
        case .third:
            timers[timer.index()] = .third(time: newValue)
        }
        save(timers)
    }
    

    func getTimers() -> [CustomTimer] {
        
        guard let arrayOfTimes = plistReader.readPlist()[timersKey] as? [AnyObject] else {
            fatalError()
        }
        
        var timers: [CustomTimer] = []
        for (index, time) in arrayOfTimes.enumerated() {
            guard let time = Double(time as! String) else {
                fatalError()
            }
            timers.append(CustomTimer(index: index, time: time))
        }
        
        return timers
    }
    
    static func shortcutItemForTime(_ timer: CustomTimer) -> UIApplicationShortcutItem {
        let shorcutIcon = UIApplicationShortcutIcon(type: .time)
        return UIApplicationShortcutItem(type: timer.uniqueKey(), localizedTitle: timer.title(), localizedSubtitle: "Counting Down", icon: shorcutIcon, userInfo: nil)
    }
    
    func archiveFormat(_ timers: [CustomTimer]) -> NSDictionary {
        let timerValues: [String] = timers.map {
            switch $0 {
            case .first(let time):
                return String(time)
            case .second(let time):
                return String(time)
            case .third(let time):
                return String(time)
            }
        }
        let dict = NSMutableDictionary()
        dict.setValue(timerValues, forKey: timersKey)
        return dict
    }
    
    func save(_ timers: [CustomTimer]) {
        plistReader.save(archiveFormat(timers))
        let shortcutItems = timers.map {
            CustomTimerManager.shortcutItemForTime($0)
        }
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
}

enum CustomTimer {
    
    case first(time: Double)
    case second(time: Double)
    case third(time: Double)
    
    init(index: Int, time: Double) {
        switch index {
        case 0:
            self = .first(time: time)
        case 1:
            self = .second(time: time)
        case 2:
            self = .third(time: time)
        default:
            fatalError()
        }
    }
    
    func uniqueKey() -> String {
        switch self {
        case .first:
            return "firstCustomTimer"
        case .second:
            return "secondCustomTimer"
        case .third:
            return "thirdCustomTimer"
        }
    }
    
    func title() -> String {
        let formatter = TimeFormatter(separator: ":")
        switch self {
        case .first(let time):
            return formatter.formatTime(time: time).formattedString
        case .second(let time):
            return formatter.formatTime(time: time).formattedString
        case .third(let time):
            return formatter.formatTime(time: time).formattedString
        }
    }
    
    func index() -> Int {
        switch self {
        case .first:
            return 0
        case .second:
            return 1
        case .third:
            return 2
        }
    }
}
