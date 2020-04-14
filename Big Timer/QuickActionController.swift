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
    
    let timerController: TimerController
    
    init(timerController: TimerController) {
        self.timerController = timerController
        self.setupCustomActions()
    }
    
    func setupCustomActions() {
        let shortcutItems = CustomTimerManager().getTimers().map {
            CustomTimerManager.shortcutItemForTime(timer: $0)
        }
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
    func handleAction(shortcutItem: UIApplicationShortcutItem) {
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
    
    func countUpQuickAction() {
        timerController.setTimer(timeInSeconds: 0, direction: .Up)
    }
    
    func firstCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for timer in timers {
            if case .First(let time) = timer {
                timerController.setTimer(timeInSeconds: time, direction: .Down)
            }
        }
    }
    
    func secondCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for timer in timers {
            if case .Second(let time) = timer {
                timerController.setTimer(timeInSeconds: time, direction: .Down)
            }
        }
    }
    
    func thirdCustomTimer() {
        let timers: [CustomTimer] = CustomTimerManager().getTimers()
        for timer in timers {
            if case .Third(let time) = timer {
                timerController.setTimer(timeInSeconds: time, direction: .Down)
            }
        }
    }

}
