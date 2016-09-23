//
//  TimeArchive.swift
//  Big Timer
//
//  Created by Joel Klabo on 3/25/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

open class TimerState: NSObject, NSCoding {
    
    var timeStamp: Date!
    var timerValue: CFTimeInterval!
    var direction: TimerDirection!
    var isRunning: Bool!
    
    required convenience public init?(coder decoder: NSCoder) {
        self.init()
        self.timeStamp = decoder.decodeObject(forKey: "timeStamp") as! Date?
        self.timerValue = decoder.decodeObject(forKey: "timerValue") as! CFTimeInterval?
        self.direction = TimerDirection(rawValue:decoder.decodeObject(forKey: "direction") as! TimerDirection.RawValue)
        self.isRunning = decoder.decodeObject(forKey: "isRunning") as! Bool
    }
    
    class func newState(_ timerValue: Int, direction: TimerDirection, isRunning: Bool) -> TimerState {
        return TimerState.newState(CFTimeInterval(timerValue), direction: direction, isRunning: isRunning)
    }
    
    class func newState(_ timerValue: CFTimeInterval, direction: TimerDirection, isRunning: Bool) -> TimerState {
        let newTimerState = TimerState()
        newTimerState.timeStamp = Date()
        newTimerState.timerValue = timerValue
        newTimerState.direction = direction
        newTimerState.isRunning = isRunning
        return newTimerState
    }
    
    class func zeroState() -> TimerState {
        return TimerState.newState(0, direction: .Up, isRunning: false)
    }
    
    open func encode(with coder: NSCoder) {
        coder.encode(self.timeStamp, forKey: "timeStamp")
        coder.encode(self.timerValue, forKey: "timerValue")
        coder.encode(self.direction.rawValue, forKey: "direction")
        coder.encode(self.isRunning, forKey: "isRunning")
    }
    
    override open func isEqual(_ object: Any?) -> Bool {
        if (object as AnyObject).isKind(of: TimerState.self) {
            let timeState = object as! TimerState
            if (timeState.timeStamp == self.timeStamp
            &&  timeState.timerValue == self.timerValue
            &&  timeState.direction == self.direction
            &&  timeState.isRunning == self.isRunning) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}

enum TimerDirection: String {
    case Up = "up"
    case Down = "down"
}
