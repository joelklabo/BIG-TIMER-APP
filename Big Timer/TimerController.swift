//
//  TimerController.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/10/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

@objc protocol TimerManagerDelegate {
    func timerUpdate(_ timerState: TimerState)
    func timerDone()
}

class TimerController: NSObject, TimerManagerDelegate, TimerDelegate {
    
    fileprivate var foregrounding = false
    
    static let instance = TimerController()
    
    var delegate: TimerManagerDelegate?
    
    fileprivate var currentTimerState: TimerState = TimerState.zeroState() {
        didSet {
            if (currentTimerState.timerValue < 0) {
                currentTimerState = TimerState.zeroState()
                Timer.instance.stop()
                if (!foregrounding) {
                    delegate?.timerDone()
                }
            }
            delegate?.timerUpdate(self.currentTimerState)
        }
    }
    
    override init () {
        super.init()
        Timer.instance.delegate = self
    }
    
    func toggle () {
        Timer.instance.toggle()
        updateTimer(0)
    }
    
    func clear () {
        Timer.instance.stop()
        currentTimerState = TimerState.zeroState()
    }
    
    func modifyTime (_ time: CFTimeInterval) {
        let newTime = currentTimerState.timerValue + time
        currentTimerState = TimerState.newState(newTime, direction: currentTimerState.direction, isRunning: Timer.instance.isTimerRunning())
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == .Up) {
            currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: .Down, isRunning: Timer.instance.isTimerRunning())
        } else {
            currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: .Up, isRunning: Timer.instance.isTimerRunning())
        }
    }
    
    func setTimer(_ timeInSeconds: Int, direction: TimerDirection) {
        currentTimerState = TimerState.newState(timeInSeconds, direction: direction, isRunning: true)
        Timer.instance.go()
    }
    
    func setTimerToDirection(_ direction: TimerDirection) {
        currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: direction, isRunning: Timer.instance.isTimerRunning())
    }
    
    func returningFromBackground () {
        
        foregrounding = true
        
        if let archivedTimerState = TimerStateArchiver.retrieveTimerState(),
                let updatedTimerState = TimerStateArchiver.updateTimerState(archivedTimerState, forDate: Date()) {
            currentTimerState = updatedTimerState
        } else {
            currentTimerState = TimerState.zeroState()
        }
        
        if (currentTimerState.isRunning == true) {
            Timer.instance.go()
        }
        
    }
    
    func enteringBackground () {
        
        // This should be handled when we stop the timer
        if Timer.instance.isTimerRunning() {
            currentTimerState.isRunning = true
        } else {
            currentTimerState.isRunning = false
        }
        
        TimerStateArchiver.archiveTimerState(currentTimerState)
        Timer.instance.stop()
    }
    
    fileprivate func updateTimerValue(_ timerValue: CFTimeInterval, timeDelta: CFTimeInterval, direction: TimerDirection) -> CFTimeInterval {
        var newTimerValue: CFTimeInterval = 0
        if (direction == .Up) {
            newTimerValue = timerValue + timeDelta
        } else {
            newTimerValue = timerValue - timeDelta
        }
        return newTimerValue
    }
    
    func timerUpdate(_ timerState: TimerState) {
        delegate?.timerUpdate(timerState)
    }
    
    func timerDone() {
        delegate?.timerDone()
    }
        
    func tick(_ timeDelta: CFTimeInterval) {
        updateTimer(timeDelta)
    }
    
    func updateTimer(_ timeDelta: CFTimeInterval) {
        foregrounding = false
        let timerValue = updateTimerValue(currentTimerState.timerValue, timeDelta: timeDelta, direction: currentTimerState.direction)
        currentTimerState = TimerState.newState(timerValue, direction: currentTimerState.direction, isRunning: Timer.instance.isTimerRunning())
    }
    
}
