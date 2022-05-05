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
    
    private let uniqueIdentifier = UUID().uuidString
    
    private let notificationController = NotificationController()
    
    private let timer = Timer()

    private var foregrounding = false
        
    var delegate: TimerManagerDelegate?
    
    private var currentTimerState: TimerState = TimerState.zero {
        didSet {
            if (currentTimerState.timerValue <= 0) {
                timer.stop()
                if (!foregrounding && currentTimerState.isRunning) {
                    delegate?.timerDone()
                }
                currentTimerState = TimerState.zero
            }
            delegate?.timerUpdate(timerState: self.currentTimerState)
        }
    }
    
    var isAtZero: Bool {
        let isRunning = currentTimerState.isRunning == false
        let isAtZero = currentTimerState.timerValue == 0.0
        return isRunning && isAtZero
    }
    
    override init () {
        super.init()
        timer.delegate = self
    }
    
    func toggle () {
        timer.toggle()
    }
    
    func clear () {
        timer.stop()
        currentTimerState = TimerState.zero
        notificationController.clearNotifications()
    }
    
    func modifyTime (time: Double) {
        let newTime = currentTimerState.timerValue + time
        currentTimerState = TimerState.newState(timerValue: newTime, direction: .Down, isRunning: timer.isTimerRunning())
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == .Up) {
            currentTimerState = TimerState.newState(timerValue: currentTimerState.timerValue, direction: .Down, isRunning: timer.isTimerRunning())
        } else {
            currentTimerState = TimerState.newState(timerValue: currentTimerState.timerValue, direction: .Up, isRunning: timer.isTimerRunning())
        }
    }
    
    func setTimer(timeInSeconds: Int, direction: TimerDirection) {
        currentTimerState = TimerState.newState(timerValue: timeInSeconds, direction: direction, isRunning: true)
        timer.go()
    }
    
    func setTimerToDirection(direction: TimerDirection) {
        currentTimerState = TimerState.newState(timerValue: currentTimerState.timerValue, direction: direction, isRunning: timer.isTimerRunning())
    }
    
    func enteringForeground () {
        
        foregrounding = true
        
        if let archivedTimerState = TimerStateArchiver.retrieve(key: uniqueIdentifier),
            let updatedTimerState = TimerStateArchiver.update(archivedTimerState) {
                currentTimerState = updatedTimerState
        } else {
            currentTimerState = TimerState.zero
        }        
        
        if (currentTimerState.isRunning == true) {
            timer.go()
        }
        
    }
    
    func enteringBackground () {
        
        // This should be handled when we stop the timer
        if timer.isTimerRunning() {
            currentTimerState.isRunning = true
            notificationController.queue(timerState: currentTimerState)
        } else {
            currentTimerState.isRunning = false
        }
        
        TimerStateArchiver.archive(currentTimerState, key: uniqueIdentifier)
    }
    
    private func currentTimerValue(timerValue: Double, timeDelta: Double, direction: TimerDirection) -> Double {
        var newTimerValue: Double = 0
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
        
    func tick(timePassed timeDelta: Double) {
        foregrounding = false
        let timerValue = currentTimerValue(timerValue: currentTimerState.timerValue, timeDelta: timeDelta, direction: currentTimerState.direction)
        currentTimerState = TimerState.newState(timerValue: timerValue, direction: currentTimerState.direction, isRunning: timer.isTimerRunning())
    }
    
}
