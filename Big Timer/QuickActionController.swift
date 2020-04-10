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
            CustomTimerManager.shortcutItemForTime(timer: $0)
        }
        UIApplication.shared.shortcutItems = shortcutItems
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
        TimerController.instance.setTimer(timeInSeconds: 0, direction: .Up)
    }
    
    static func firstCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for timer in timers {
            if case .First(let time) = timer {
                TimerController.instance.setTimer(timeInSeconds: time, direction: .Down)
            }
        }
    }
    
    static func secondCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for timer in timers {
            if case .Second(let time) = timer {
                TimerController.instance.setTimer(timeInSeconds: time, direction: .Down)
            }
        }
    }
    
    static func thirdCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for timer in timers {
            if case .Third(let time) = timer {
                TimerController.instance.setTimer(timeInSeconds: time, direction: .Down)
            }
        }
    }

}
