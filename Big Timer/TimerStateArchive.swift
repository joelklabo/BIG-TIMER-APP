//
//  TimerStateStore.swift
//  Big Timer
//
//  Created by Joel Klabo on 3/24/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

struct TimerStateArchiver {
 
    static fileprivate let userDefaultsKey = "timerValue-2"
    
    static func archiveTimerState (_ state: TimerState) {
        let ecodableState = EncodableTimerState(state: state)
        NSKeyedArchiver.setClassName("EncodableTimerState", for: EncodableTimerState.self)
        let data = NSKeyedArchiver.archivedData(withRootObject: ecodableState)
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
    
    static func retrieveTimerState() -> TimerState? {
        NSKeyedUnarchiver.setClass(EncodableTimerState.self, forClassName: "EncodableTimerState")
        if let data = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data,
            let encodedState = NSKeyedUnarchiver.unarchiveObject(with: data) as? EncodableTimerState {
            return encodedState.state
        }
        return nil
    }
}

class EncodableTimerState: NSObject, NSCoding {
    
    var state: TimerState?
    
    init(state: TimerState?) {
        self.state = state
    }
    
    required init?(coder decoder: NSCoder) {
        guard
            let timeStamp = decoder.decodeObject(forKey: "timeStamp") as? Date,
            let timerValue = decoder.decodeObject(forKey: "timerValue") as? CFTimeInterval,
            let directionKey = decoder.decodeObject(forKey: "direction") as? String,
            let isRunning = decoder.decodeObject(forKey: "isRunning") as? Bool,
            let direction = TimerDirection(rawValue: directionKey) else { return nil }
        
        state = TimerState(timeStamp: timeStamp, timerValue: timerValue, direction: direction, isRunning: isRunning)
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(state?.timeStamp, forKey: "timeStamp")
        coder.encode(state?.timerValue, forKey: "timerValue")
        coder.encode(state?.direction.rawValue, forKey: "direction")
        coder.encode(state?.isRunning, forKey: "isRunning")
    }
}
