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
    func timerUpdate(timerState: TimerState)
    func timerDone()
}

class TimerController: NSObject, TimerDelegate {
    
    private var currentTimerState: TimerState = TimerState.zeroState() {
        didSet {
            if (currentTimerState.timerValue < 0) {
                currentTimerState.timerValue = 0
                currentTimerState.direction = .Up
                timer.pauseTimer()
                notifySubscribersTimerDone()
            }
            updateSubscribers(currentTimerState)
        }
    }
    
    private var subscribers: [TimerManagerDelegate] = Array()
    
    private let timer = Timer()
    
    override init () {
        super.init()
        timer.delegate = self
    }
    
    func toggle () {
        timer.toggle()
    }
    
    func clear () {
        timer.pauseTimer()
        currentTimerState = TimerState.zeroState()
    }
    
    func modifyTime (time: CFTimeInterval) {
        timer.pauseTimer()
        let newTime = currentTimerState.timerValue + time
        if (newTime <= 1) {
            currentTimerState = TimerState.zeroState()
        } else {
            currentTimerState = TimerState.newState(newTime, direction: currentTimerState.direction, isRunning: !timer.isPaused())
        }
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == TimerDirection.Up) {
            currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: TimerDirection.Down, isRunning: !timer.isPaused())
        } else {
            currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: TimerDirection.Up, isRunning: !timer.isPaused())
        }
    }
    
    func setTimerToDirection(direction: TimerDirection) {
        currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: direction, isRunning: !timer.isPaused())
    }
    
    // MARK: Timer Lifecycle
    func returningFromBackground () {
        
        if let archive = TimerStateArchive.retrieveTimerState() {
            
            if (archive.isRunning != true) {
                currentTimerState = TimerState.newState(archive.timerValue, direction: archive.direction, isRunning: archive.isRunning)
                return
            }
            
            let timerValue = archive.timerValue!
            let timeSinceBackground = NSDate().timeIntervalSinceDate(archive.timeStamp!)
            let timeLeftOnTimer = updatedTimerValue(timerValue, timeDelta: timeSinceBackground, direction: archive.direction)
            
            currentTimerState = TimerState.newState(timeLeftOnTimer, direction: archive.direction, isRunning: archive.isRunning)
            
        } else {
            currentTimerState = TimerState.zeroState()
        }
        
        if (currentTimerState.isRunning == true) {
            timer.startTimer()
        }
        
    }
    
    func enteringBackground () {
        TimerStateArchive.archiveTimerState(TimerState.newState(currentTimerState.timerValue, direction: currentTimerState.direction, isRunning: !timer.isPaused()))
        timer.pauseTimer()
    }
    
    func subscribeToTimerUpdates (subscriber: TimerManagerDelegate) {
        self.subscribers.append(subscriber)
    }
    
    // MARK: - Private Helper Functions
    
    private func updatedTimerValue(timerValue: CFTimeInterval, timeDelta: CFTimeInterval, direction: TimerDirection) -> CFTimeInterval {
        
        var newTimerValue: CFTimeInterval
        
        if (direction == .Up) {
            newTimerValue = timerValue + timeDelta
        } else {
            newTimerValue = timerValue - timeDelta
        }
        
        return newTimerValue
    }
    
    // MARK: - Timer Update Notifications
    
    private func updateSubscribers(timerState: TimerState) {
        for subscriber in subscribers {
            subscriber.timerUpdate(currentTimerState)
        }
    }
    
    private func notifySubscribersTimerDone() {
        for subscriber in subscribers {
            subscriber.timerDone()
        }
    }
    
    // MARK: - TimerStateArchiver
    
    private func storeTimerState(timerState: TimerState) {
        TimerStateArchive.archiveTimerState(timerState)
    }
    
    // MARK: - TimerDelegate methods
    
    func tick(timeDelta: CFTimeInterval) {
        
        let timerValue = updatedTimerValue(currentTimerState.timerValue, timeDelta: timeDelta, direction: currentTimerState.direction)

        currentTimerState = TimerState.newState(timerValue, direction: currentTimerState.direction, isRunning: !timer.isPaused())
    }
    
}