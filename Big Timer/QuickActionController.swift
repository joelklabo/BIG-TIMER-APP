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
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
    static func handleAction(_ shortcutItem: UIApplicationShortcutItem) {
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
        TimerController.instance.setTimerFromQuickAction(timerValue: 0, direction: .up)
    }
    
    static func firstCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for (_, timer) in timers.enumerated() {
            if case .first(let time) = timer {
                TimerController.instance.setTimerFromQuickAction(timerValue: time, direction: .down)
            }
        }
    }
    
    static func secondCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for (_, timer) in timers.enumerated() {
            if case .second(let time) = timer {
                TimerController.instance.setTimerFromQuickAction(timerValue: time, direction: .down)

            }
        }
    }
    
    static func thirdCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for (_, timer) in timers.enumerated() {
            if case .third(let time) = timer {
                TimerController.instance.setTimerFromQuickAction(timerValue: time, direction: .down)
            }
        }
    }

}
