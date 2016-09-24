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
    func timerUpdate(encodedTimerState: EncodableTimerState)
    func timerDone()
}

class TimerController: NSObject {
    
    static let instance = TimerController()
    
    var delegate: TimerManagerDelegate?
    
    var launchedFromQuickAction = false
    
    var currentTimerState: TimerState = TimerState.zeroState() {
        didSet {
            if (currentTimerState.timerValue < 0) {
                currentTimerState = TimerState.zeroState()
                Timer.instance.stop()
                delegate?.timerDone()
            }
            delegate?.timerUpdate(encodedTimerState: EncodableTimerState(state: currentTimerState))
        }
    }
    
    override init() {
        super.init()
        Timer.instance.delegate = self
    }
    
    func update(direction: TimerDirection) {
        currentTimerState = currentTimerState.update(direction: direction)
    }
    
    func adjust(time: Double) {
        currentTimerState = currentTimerState.adjust(byTime: time)
    }
    
    func toggleTimer() {
        Timer.instance.toggle()
    }
    
    func clear() {
        Timer.instance.stop()
        currentTimerState = TimerState.zeroState()
    }
    
    func adjust(byTime time: Double) {
        currentTimerState = currentTimerState.adjust(byTime: time)
    }
    
    func toggleDirection() {
        if (currentTimerState.direction == .up) {
            currentTimerState = currentTimerState.update(direction: .down)
        } else {
            currentTimerState = currentTimerState.update(direction: .up)
        }
    }
    
    func setTimerFromQuickAction(timerValue: Double, direction: TimerDirection) {
        launchedFromQuickAction = true
        currentTimerState = currentTimerState.update(timerValue: timerValue).update(direction: direction)
        Timer.instance.go()
    }
    
    func returningFromBackground() {
        
        if !launchedFromQuickAction {
            if let archivedTimerState = TimerStateArchiver.retrieveTimerState(),
                let updatedTimerState = updateTimerStateFromBackground(state: archivedTimerState, forDate: Date()) {
                currentTimerState = updatedTimerState
            } else {
                currentTimerState = TimerState.zeroState()
            }
        }
        
        if (currentTimerState.isRunning == true) {
            Timer.instance.go()
        }
        
        launchedFromQuickAction = false
    }
    
    func enteringBackground() {
        TimerStateArchiver.archiveTimerState(currentTimerState)
        Timer.instance.stop()
    }
    
    func updateTimerValue(timerValue: Double, timeDelta: Double, direction: TimerDirection) -> Double {
        var newTimerValue: Double = 0
        if (direction == .up) {
            newTimerValue = timerValue + timeDelta
        } else {
            newTimerValue = timerValue - timeDelta
        }
        return newTimerValue
    }
    
    func updateTimer(timeDelta: Double) {
        let timerValue = updateTimerValue(timerValue: currentTimerState.timerValue, timeDelta: timeDelta, direction: currentTimerState.direction)
        currentTimerState = TimerState(timeStamp: Date(), timerValue: timerValue, direction: currentTimerState.direction, isRunning: currentTimerState.isRunning)
    }
    
    func updateTimerStateFromBackground(state: TimerState, forDate currentDate: Date) -> TimerState? {
        if !state.isRunning { return state }
        let timerValue = state.timerValue
        let timeSinceBackgrounded = currentDate.timeIntervalSince(state.timeStamp)
        let currentTimeOnTimer = updateTimerValue(timerValue: timerValue, timeDelta: timeSinceBackgrounded, direction: state.direction)
        if currentTimeOnTimer > 0 {
            return TimerState(timeStamp: currentDate, timerValue: currentTimeOnTimer, direction: state.direction, isRunning: state.isRunning)
        } else {
            return nil
        }
    }
}

extension TimerController: TimerManagerDelegate {
    func timerUpdate(encodedTimerState: EncodableTimerState) {
        delegate?.timerUpdate(encodedTimerState: encodedTimerState)
    }
    func timerDone() {
        delegate?.timerDone()
    }
}

extension TimerController: TimerDelegate {
    func tick(timePassed: Double) {
        updateTimer(timeDelta: timePassed)
    }
    func isRunning(_ isRunning: Bool) {
        currentTimerState = currentTimerState.update(isRunning: isRunning)
    }
}
