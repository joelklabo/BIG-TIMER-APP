//
//  TimerStateStore.swift
//  Big Timer
//
//  Created by Joel Klabo on 3/24/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

class TimerStateArchiver {
 
    class func archive(_ timeArchive: TimerState) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(timeArchive) {
            UserDefaults.standard.set(data, forKey: "timer")
        }
    }
    
    class func retrieveTimerState() -> TimerState? {
        let decoder = JSONDecoder()

        guard let data = UserDefaults.standard.object(forKey: "timer") as? Data,
            let archive = try? decoder.decode(TimerState.self, from: data) else {
            return nil
        }

        return archive
    }
    
    class func update(_ timerState: TimerState, forDate currentDate: Date = Date()) -> TimerState? {
        
        guard timerState.isRunning == true else {
            return TimerState(timeStamp: currentDate,
                              timerValue: timerState.timerValue,
                              direction: timerState.direction,
                              isRunning: timerState.isRunning)
        }
        
        let timerValue = timerState.timerValue
        let timeSinceBackgrounded = currentDate.timeIntervalSince(timerState.timeStamp)
        let currentTimeOnTimer = timerState.direction == .Up ? timerValue + timeSinceBackgrounded : timerValue - timeSinceBackgrounded
        if currentTimeOnTimer > 0 {
            return TimerState.newState(timerValue: currentTimeOnTimer, direction: timerState.direction, isRunning: timerState.isRunning)
        } else {
            return nil
        }
    }
    
}
