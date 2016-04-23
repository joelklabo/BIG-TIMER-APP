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
    
    enum Direction {
        case Up
        case Down
    }
    
    private var foregrounding = false
    
    private var subscribers = [TimerManagerDelegate]()
    
    private let timer = Timer()
    
    private var direction: Direction = .Up {
        didSet (direction) {
            print("new direction \(direction)")
        }
    }
    
    private var currentTimerState: TimerState = TimerState.zeroState() {
        didSet {
            if (currentTimerState.timerValue < 0) {
                currentTimerState = TimerState.zeroState()
                timer.stop()
                if (!foregrounding) {
                    notifySubscribersTimerDone()
                }
            }
            updateSubscribers(currentTimerState)
        }
    }
    
    override init () {
        super.init()
        timer.delegate = self
    }
    
    func toggle () {
        if timer.isTimerRunning() {
            timer.stop()
        } else {
            timer.go()
        }
    }
    
    func clear () {
        timer.stop()
        currentTimerState = TimerState.zeroState()
    }
    
    func modifyTime (time: CFTimeInterval) {
        timer.stop()
        let newTime = currentTimerState.timerValue + time
        if (newTime <= 1) {
            currentTimerState = TimerState.zeroState()
        } else {
            currentTimerState = TimerState.newState(newTime, direction: currentTimerState.direction, isRunning: timer.isTimerRunning())
        }
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == TimerDirection.Up) {
            currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: TimerDirection.Down, isRunning: timer.isTimerRunning())
        } else {
            currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: TimerDirection.Up, isRunning: timer.isTimerRunning())
        }
    }
    
    func setTimerToDirection(direction: TimerDirection) {
        currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: direction, isRunning: timer.isTimerRunning())
    }
    
    // MARK: Timer Lifecycle
    func returningFromBackground () {
        
        foregrounding = true
        
        if let archive = TimerStateArchive.retrieveTimerState() {
            
            if (archive.isRunning == false) {
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
            timer.go()
        }
        
    }
    
    func enteringBackground () {
        TimerStateArchive.archiveTimerState(TimerState.newState(currentTimerState.timerValue, direction: currentTimerState.direction, isRunning: timer.isTimerRunning()))
        timer.stop()
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
        
        foregrounding = false
        
        let timerValue = updatedTimerValue(currentTimerState.timerValue, timeDelta: timeDelta, direction: currentTimerState.direction)

        currentTimerState = TimerState.newState(timerValue, direction: currentTimerState.direction, isRunning: timer.isTimerRunning())
    }
    
}