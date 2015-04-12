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
}

class TimerController: NSObject, TimerDelegate {
    
    private var currentTimerState: TimerState = TimerState.newState(NSDate(), timerValue: 0, direction: .Up) {
        didSet {
            updateSubscribers(currentTimerState)
            TimerStateArchive().archiveTimerState(currentTimerState)
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
        timer.clear()
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
    
    // MARK: - TimerStateArchiver
    
    private func storeTimerState(timerState: TimerState) {
        TimerStateArchive().archiveTimerState(timerState)
    }
    
    // MARK: - TimerDelegate methods
    
    func tick(timeDelta: Time) {
        
        let timeStamp = NSDate()
        let timerDirection = currentTimerState.direction
        let timerValue: NSTimeInterval
        
        if (timerDirection == TimerDirection.Up) {
            timerValue = currentTimerState.timerValue + timeDelta
        } else {
            timerValue = currentTimerState.timerValue - timeDelta
        }
        
        currentTimerState = TimerState.newState(timeStamp, timerValue: timerValue, direction: timerDirection)
    }
    
}