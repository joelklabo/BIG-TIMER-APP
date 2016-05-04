//
//  TimerStateStore.swift
//  Big Timer
//
//  Created by Joel Klabo on 3/24/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

class TimerStateArchiver {
 
    class func archiveTimerState (timeArchive: TimerState) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(timeArchive)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "timer")
    }
    
    class func retrieveTimerState() -> TimerState? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("timer") as? NSData {
            let timeArchive = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! TimerState
            return timeArchive
        }
        return nil
    }
    
    class func updateTimerState(timerState: TimerState, forDate currentDate: NSDate) -> TimerState? {
        guard timerState.isRunning == true else {
            timerState.timeStamp = currentDate
            return timerState
        }
        let timerValue = timerState.timerValue
        let timeSinceBackgrounded = currentDate.timeIntervalSinceDate(timerState.timeStamp)
        let currentTimeOnTimer = timerState.direction == .Up ? timerValue + timeSinceBackgrounded : timerValue - timeSinceBackgrounded
        if currentTimeOnTimer > 0 {
            return TimerState.newState(currentTimeOnTimer, direction: timerState.direction, isRunning: timerState.isRunning)
        } else {
            return nil
        }
    }
    
}