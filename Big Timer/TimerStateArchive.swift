//
//  TimerStateStore.swift
//  Big Timer
//
//  Created by Joel Klabo on 3/24/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

class TimerStateArchiver {
 
    class func archiveTimerState (_ timeArchive: TimerState) {
        let data = NSKeyedArchiver.archivedData(withRootObject: timeArchive)
        UserDefaults.standard.set(data, forKey: "timer")
    }
    
    class func retrieveTimerState() -> TimerState? {
        if let data = UserDefaults.standard.object(forKey: "timer") as? Data {
            let timeArchive = NSKeyedUnarchiver.unarchiveObject(with: data) as! TimerState
            return timeArchive
        }
        return nil
    }
    
    class func updateTimerState(_ timerState: TimerState, forDate currentDate: Date) -> TimerState? {
        guard timerState.isRunning == true else {
            timerState.timeStamp = currentDate
            return timerState
        }
        let timerValue = timerState.timerValue
        let timeSinceBackgrounded = currentDate.timeIntervalSince(timerState.timeStamp as Date)
        let currentTimeOnTimer = timerState.direction == .Up ? timerValue! + timeSinceBackgrounded : timerValue! - timeSinceBackgrounded
        if currentTimeOnTimer > 0 {
            return TimerState.newState(currentTimeOnTimer, direction: timerState.direction, isRunning: timerState.isRunning)
        } else {
            return nil
        }
    }
    
}
