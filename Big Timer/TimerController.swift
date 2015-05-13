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
        let timerValue: NSTimeInterval
        
        if (currentTimerState.direction == TimerDirection.Up) {
            timerValue = currentTimerState.timerValue + timeDelta
        } else {
            timerValue = currentTimerState.timerValue - timeDelta
        }
        
        currentTimerState = TimerState.newState(timeStamp, timerValue: timerValue, direction: currentTimerState.direction)
    }
    
}