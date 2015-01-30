//
//  Clock.swift
//  Big Timer
//
//  Created by Joel Klabo on 1/29/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation

typealias TimeState = (hours: Int, minutes: Int, seconds: Int)

class Clock: NSObject {
    
    var delegate: ClockUpdateDelegate?
    
    private var seconds: Int
    private var minutes: Int
    private var hours: Int
    private var state: ClockState
    
    private var timer: NSTimer?
    
    override init () {
        self.seconds = 0
        self.minutes = 0
        self.hours = 0
        self.state = .Cleared
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
       
        delegate?.clockUpdate(timeState(), clockState: self.currentState())
    }
    
    private func clearState () {
        self.seconds = 0
        self.minutes = 0
        self.hours = 0
    }
    
    private func timeState () -> TimeState {
        return (hours: self.hours, minutes: self.minutes, seconds: self.seconds)
    }
    
    func start () {
        state = .Running
        delegate?.clockUpdate(timeState(), clockState: self.currentState())
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("tick"), userInfo: nil, repeats: true)
    }
    
    func pause () {
        state = .Paused
        delegate?.clockUpdate(timeState(), clockState: self.currentState())
        timer?.invalidate()
    }
    
    func clear () {
        state = .Cleared
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
    case Cleared
}