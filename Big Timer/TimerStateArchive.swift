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
    
    class func retrieveTimerState () -> TimerState? {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("timer") as? NSData {
            let timeArchive = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! TimerState
            return timeArchive
        }
        
        return nil
    }
    
}