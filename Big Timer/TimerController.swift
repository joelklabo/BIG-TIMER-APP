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
    func timerUpdate(_ encodedTimerState: EncodableTimerState)
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
            delegate?.timerUpdate(EncodableTimerState(state: currentTimerState))
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
        currentTimerState = TimerState(timeStamp: currentTimerState.timeStamp, timerValue: newTime, direction: currentTimerState.direction, isRunning: currentTimerState.isRunning)
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == .up) {
            setTimerToDirection(.down)
        } else {
            setTimerToDirection(.up)
        }
    }
    
    func setTimer(_ timerValue: Double, direction: TimerDirection) {
        currentTimerState = TimerState(timeStamp: Date(), timerValue: timerValue, direction: direction, isRunning: true)
        Timer.instance.go()
    }
    
    func setTimerToDirection(_ direction: TimerDirection) {
        currentTimerState = TimerState(timeStamp: currentTimerState.timeStamp, timerValue: currentTimerState.timerValue, direction: direction, isRunning: currentTimerState.isRunning)
    }
    
    func returningFromBackground () {
        foregrounding = true
        if let archivedTimerState = TimerStateArchiver.retrieveTimerState(),
                let updatedTimerState = updateTimerState(archivedTimerState, forDate: Date()) {
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
        if (direction == .up) {
            newTimerValue = timerValue + timeDelta
        } else {
            newTimerValue = timerValue - timeDelta
        }
        return newTimerValue
    }
    
    func timerUpdate(_ encodedTimerState: EncodableTimerState) {
        delegate?.timerUpdate(encodedTimerState)
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
        currentTimerState = TimerState(timeStamp: currentTimerState.timeStamp, timerValue: timerValue, direction: currentTimerState.direction, isRunning: currentTimerState.isRunning)
    }
    
    fileprivate func updateTimerState(_ state: TimerState, forDate currentDate: Date) -> TimerState? {
        let timerValue = state.timerValue
        let timeSinceBackgrounded = currentDate.timeIntervalSince(state.timeStamp)
        let currentTimeOnTimer = updateTimerValue(timerValue, timeDelta: timeSinceBackgrounded, direction: state.direction)
        if currentTimeOnTimer > 0 {
            return TimerState(timeStamp: currentDate, timerValue: currentTimeOnTimer, direction: state.direction, isRunning: state.isRunning)
        } else {
            return nil
        }
    }
        
}
