//
//  Clock.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/29/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

typealias TimeState = (hours: Int, minutes: Int, seconds: Int)

class Clock: NSObject {
    
    var delegate: ClockUpdateDelegate?
    
    private var milliseconds: Double
    private var seconds: Int
    private var minutes: Int
    private var hours: Int
    private var state: ClockState
    
    private var timer: CADisplayLink?
    
    private var lastTick: Double
    
    override init () {
        self.milliseconds = 0
        self.seconds = 0
        self.minutes = 0
        self.hours = 0
        self.state = .Cleared
        
        self.lastTick = 0
    }
    
    func update () {
        if (lastTick == 0) {
            lastTick = CACurrentMediaTime() as Double
            return
        }
        let currentTime = CACurrentMediaTime() as Double
        let timeDelta = currentTime - lastTick
        let timeDeltaMilliseconds = (timeDelta * 1000)
        self.millitick(timeDeltaMilliseconds)
        lastTick = currentTime
    }
    
    func millitick (milliseconds: Double) {
        self.milliseconds += milliseconds
        if (self.milliseconds >= 1000) {
            self.milliseconds = 0
            self.tick()
        }
        delegate?.clockUpdate(timeState(), clockState: self.currentState())
    }
    
    func tick () {
        self.seconds++
        if (self.seconds == 60) {
            self.seconds = 0
            self.minutes++
        } else if (self.minutes == 60) {
            self.minutes = 0
            self.hours++
        }
        delegate?.clockUpdate(timeState(), clockState: .Sync)
    }
    
    private func clearState () {
        self.milliseconds = 0
        self.seconds = 0
        self.minutes = 0
        self.hours = 0
        self.lastTick = 0
        self.state = .Cleared
    }
    
    private func timeState () -> TimeState {
        return (hours: self.hours, minutes: self.minutes, seconds: self.seconds)
    }
    
    func start () {
        timer = CADisplayLink(target: self, selector: Selector("update"))
        timer?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        state = .Running
        delegate?.clockUpdate(timeState(), clockState: self.currentState())
    }
    
    func pause () {
        state = .Paused
        lastTick = 0
        delegate?.clockUpdate(timeState(), clockState: self.currentState())
        timer?.invalidate()
    }
    
    func clear () {
        self.clearState()
        delegate?.clockUpdate(timeState(), clockState: self.currentState())
        timer?.invalidate()
    }
    
    func currentState () -> ClockState {
        return state
    }
    
}

protocol ClockUpdateDelegate {
    func clockUpdate (timeState: TimeState, clockState: ClockState) -> Void
}

enum ClockState {
    case Running
    case Paused
    case Sync
    case Cleared
}