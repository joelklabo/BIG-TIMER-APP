//
//  QuickActionController.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/4/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

struct QuickActionController {
    
    static func setupCustomActions() {
        let shortcutItems = CustomTimerManager().getTimers().map {
            CustomTimerManager.shortcutItemForTime($0)
        }
        UIApplication.sharedApplication().shortcutItems = shortcutItems
    }
    
    static func handleAction(shortcutItem: UIApplicationShortcutItem) {
        let customShorcutkey = shortcutItem.type
        switch customShorcutkey {
        case "0":
            countUpQuickAction()
        case "firstCustomTimer":
            firstCustomTimer()
        case "secondCustomTimer":
            secondCustomTimer()
        case "thirdCustomTimer":
            thirdCustomTimer()
        default:
            fatalError("Unsupported shortcut item type")
        }
    }
    
    static func countUpQuickAction() {
        TimerController.instance.setTimer(0, direction: .Up)
    }
    
    static func firstCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for (_, timer) in timers.enumerate() {
            if case .First(let time) = timer {
                TimerController.instance.setTimer(time, direction: .Down)
            }
        }
    }
    
    static func secondCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for (_, timer) in timers.enumerate() {
            if case .Second(let time) = timer {
                TimerController.instance.setTimer(time, direction: .Down)

            }
        }
    }
    
    static func thirdCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for (_, timer) in timers.enumerate() {
            if case .Third(let time) = timer {
                TimerController.instance.setTimer(time, direction: .Down)
            }
        }
    }

}