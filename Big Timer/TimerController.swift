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
                timer.pause()
                notifySubscribersTimerDone()
            }
            updateSubscribers(currentTimerState)
        }
    }
    
    private var subscribers: [TimerManagerDelegate] = Array()
    
    private let timer = Timer()
    
    private var pauseTicks = false
    
    override init () {
        super.init()
        timer.delegate = self
    }
    
    func toggle () {
        timer.toggle()
    }
    
    func clear () {
        currentTimerState = TimerState.zeroState()
        timer.clear()
    }
    
    func modifyTime (time: Time) {
        timer.pause()
        let newTime = currentTimerState.timerValue + time
        if (newTime <= 1) {
            currentTimerState = TimerState.zeroState()
        } else {
            currentTimerState = TimerState.newState(NSDate(), timerValue: newTime, direction: currentTimerState.direction)
        }
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == TimerDirection.Up) {
            currentTimerState = TimerState.newState(NSDate(), timerValue: currentTimerState.timerValue, direction: TimerDirection.Down)
        } else {
            currentTimerState = TimerState.newState(NSDate(), timerValue: currentTimerState.timerValue, direction: TimerDirection.Up)
        }
    }
    
    func setTimerToDirection(direction: TimerDirection) {
        currentTimerState = TimerState.newState(NSDate(), timerValue: currentTimerState.timerValue, direction: direction)
    }
    
    // MARK: Timer Lifecycle
    func returningFromBackground () {
        
        if let timerStateArchive = TimerStateArchive.retrieveTimerState() {
            
            if (timerStateArchive.timerValue == 0) {
                currentTimerState = TimerState.zeroState()
                return
            }
            
            // How long has it been since the app was backgrounded
            let backgroundDate = timerStateArchive.timeStamp!
            let timeSinceBackground = NSDate().timeIntervalSinceDate(backgroundDate)
            
            // What should the new value of the timer be
            let timerValue = timerStateArchive.timerValue!
            
            var timeLeftOnTimer: NSTimeInterval
            
            if (timerStateArchive.direction == .Up) {
                timeLeftOnTimer = timerValue + timeSinceBackground
            } else {
                timeLeftOnTimer = timerValue - timeSinceBackground
            }
            
            // Is there any time left?
            if (timeLeftOnTimer > 0) {
                currentTimerState = TimerState.newState(NSDate(), timerValue: timeLeftOnTimer, direction: timerStateArchive.direction)
                timer.toggle()
            } else {
                currentTimerState = TimerState.zeroState()
            }
            
        } else {
            currentTimerState = TimerState.zeroState()
        }
        
        pauseTicks = false
    }
    
    func enteringBackground () {
        // If the timer isn't running, save the zero state
        if (timer.paused()) {
            TimerStateArchive.archiveTimerState(TimerState.zeroState())
        } else {
            TimerStateArchive.archiveTimerState(currentTimerState)
        }
        
        pauseTicks = true
        timer.pause()
    }
    
    func subscribeToTimerUpdates (subscriber: TimerManagerDelegate) {
        self.subscribers.append(subscriber)
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
    
    func tick(timeDelta: Time) {
        
        if (pauseTicks) {
            return
        }
        
        let timeStamp = NSDate()
        let timerValue: NSTimeInterval
        
        if (currentTimerState.direction == TimerDirection.Up) {
            timerValue = currentTimerState.timerValue + timeDelta
        } else {
            timerValue = currentTimerState.timerValue - timeDelta
        }
        
        currentTimerState = TimerState.newState(timeStamp, timerValue: timerValue, direction: currentTimerState.direction)
    }
    
}