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
    
    private var currentTimerState: TimerState = TimerState.newState(NSDate(), timerValue: 0, direction: .Up) {
        didSet {
            updateSubscribers(currentTimerState)
            TimerStateArchive.archiveTimerState(currentTimerState)
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
        currentTimerState = TimerState.newState(NSDate(), timerValue: 0, direction: TimerDirection.Up)
        timer.clear()
    }
    
    func modifyTime (time: Time) {
        timer.pause()
        let newTime = currentTimerState.timerValue + time
        currentTimerState = TimerState.newState(NSDate(), timerValue: newTime, direction: currentTimerState.direction)
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == TimerDirection.Up) {
            currentTimerState = TimerState.newState(NSDate(), timerValue: currentTimerState.timerValue, direction: TimerDirection.Down)
        } else {
            currentTimerState = TimerState.newState(NSDate(), timerValue: currentTimerState.timerValue, direction: TimerDirection.Up)
        }
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
        
        let timeStamp = NSDate()
        let timerDirection = currentTimerState.direction
        let timerValue: NSTimeInterval
        
        if (timerDirection == TimerDirection.Up) {
            timerValue = currentTimerState.timerValue + timeDelta
        } else {
            var newTimerValue = currentTimerState.timerValue - timeDelta
            if (newTimerValue < 0) {
                newTimerValue = 0
                clear()
                notifySubscribersTimerDone()
            }
            timerValue = newTimerValue
        }
        
        currentTimerState = TimerState.newState(timeStamp, timerValue: timerValue, direction: timerDirection)
    }
    
}