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
    
    private let timersKey = "CustomTimers"
    private let plistReader = PlistReader()
    
    func updateTimer(timer: CustomTimer, newValue: Int) {
        var timers = getTimers()
        switch timer {
        case .First:
            timers[timer.index()] = .First(time: newValue)
        case .Second:
            timers[timer.index()] = .Second(time: newValue)
        case .Third:
            timers[timer.index()] = .Third(time: newValue)
        }
        save(timers)
    }
    

    func getTimers() -> [CustomTimer] {
        
        guard let arrayOfTimes = plistReader.readPlist()[timersKey] as? [AnyObject] else {
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
    
    static func shortcutItemForTime(timer: CustomTimer) -> UIApplicationShortcutItem {
        let shorcutIcon = UIApplicationShortcutIcon(type: .Time)
        return UIApplicationShortcutItem(type: timer.uniqueKey(), localizedTitle: timer.title(), localizedSubtitle: "Counting Down", icon: shorcutIcon, userInfo: nil)
    }
    
    private func archiveFormat(timers: [CustomTimer]) -> NSDictionary {
        let timerValues: [String] = timers.map {
            switch $0 {
            case .First(let time):
                return String(time)
            case .Second(let time):
                return String(time)
            case .Third(let time):
                return String(time)
            }
        }
        let dict = NSMutableDictionary()
        dict.setValue(timerValues, forKey: timersKey)
        return dict
    }
    
    private func save(timers: [CustomTimer]) {
        plistReader.save(archiveFormat(timers))
        let shortcutItems = timers.map {
            CustomTimerManager.shortcutItemForTime($0)
        }
        UIApplication.sharedApplication().shortcutItems = shortcutItems
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
        let formatter = TimeFormatter(separator: ":")
        switch self {
        case .First(let time):
            return formatter.formatTime(time).formattedString
        case .Second(let time):
            return formatter.formatTime(time).formattedString
        case .Third(let time):
            return formatter.formatTime(time).formattedString
        }
    }
    
    func index() -> Int {
        switch self {
        case .First:
            return 0
        case .Second:
            return 1
        case .Third:
            return 2
        }
    }
}