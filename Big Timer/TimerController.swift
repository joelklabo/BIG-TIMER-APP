//
//  TimerController.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/10/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

protocol TimerManagerDelegate {
    func timerUpdate(timerState: TimerState)
    func timerDone()
}

class TimerController: NSObject, TimerManagerDelegate, TimerDelegate {
    
    private var foregrounding = false
    
    static let instance = TimerController()
    
    var delegate: TimerManagerDelegate?
    
    private var currentTimerState: TimerState = TimerState.zero {
        didSet {
            if (currentTimerState.timerValue < 0) {
                currentTimerState = TimerState.zero
                Timer.instance.stop()
                if (!foregrounding) {
                    delegate?.timerDone()
                }
            }
            delegate?.timerUpdate(timerState: self.currentTimerState)
        }
    }
    
    override init () {
        super.init()
        Timer.instance.delegate = self
    }
    
    func toggle () {
        Timer.instance.toggle()
    }
    
    func clear () {
        Timer.instance.stop()
        currentTimerState = TimerState.zero
    }
    
    func modifyTime (time: CFTimeInterval) {
        let newTime = currentTimerState.timerValue + time
        currentTimerState = TimerState.newState(timerValue: newTime, direction: currentTimerState.direction, isRunning: Timer.instance.isTimerRunning())
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == .Up) {
            currentTimerState = TimerState.newState(timerValue: currentTimerState.timerValue, direction: .Down, isRunning: Timer.instance.isTimerRunning())
        } else {
            currentTimerState = TimerState.newState(timerValue: currentTimerState.timerValue, direction: .Up, isRunning: Timer.instance.isTimerRunning())
        }
    }
    
    func setTimer(timeInSeconds: Int, direction: TimerDirection) {
        currentTimerState = TimerState.newState(timerValue: timeInSeconds, direction: direction, isRunning: true)
        Timer.instance.go()
    }
    
    func setTimerToDirection(direction: TimerDirection) {
        currentTimerState = TimerState.newState(timerValue: currentTimerState.timerValue, direction: direction, isRunning: Timer.instance.isTimerRunning())
    }
    
    func returningFromBackground () {
        
        foregrounding = true
        
        if let archivedTimerState = TimerStateArchiver.retrieveTimerState(),
            let updatedTimerState = TimerStateArchiver.update(archivedTimerState) {
            currentTimerState = updatedTimerState
        } else {
            currentTimerState = TimerState.zero
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
        
        TimerStateArchiver.archive(currentTimerState)
        Timer.instance.stop()
    }
    
    private func currentTimerValue(timerValue: CFTimeInterval, timeDelta: CFTimeInterval, direction: TimerDirection) -> CFTimeInterval {
        var newTimerValue: CFTimeInterval = 0
        if (direction == .Up) {
            newTimerValue = timerValue + timeDelta
        } else {
            newTimerValue = timerValue - timeDelta
        }
        return newTimerValue
    }
    
    func timerUpdate(timerState: TimerState) {
        delegate?.timerUpdate(timerState: timerState)
    }
    
    func timerDone() {
        delegate?.timerDone()
    }
        
    func tick(timePassed timeDelta: CFTimeInterval) {
        foregrounding = false
        let timerValue = currentTimerValue(timerValue: currentTimerState.timerValue, timeDelta: timeDelta, direction: currentTimerState.direction)
        currentTimerState = TimerState.newState(timerValue: timerValue, direction: currentTimerState.direction, isRunning: Timer.instance.isTimerRunning())
    }
    
}
