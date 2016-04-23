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
    
    private var direction: Direction = .Up {
        didSet (direction) {
            print("new direction \(direction)")
        }
    }
    
    private var currentTimerState: TimerState = TimerState.zeroState() {
        didSet {
            if (currentTimerState.timerValue < 0) {
                currentTimerState = TimerState.zeroState()
                Timer.instance.stop()
                if (!foregrounding) {
                    notifySubscribersTimerDone()
                }
            }
            updateSubscribers(currentTimerState)
        }
    }
    
    override init () {
        super.init()
        Timer.instance.delegate = self
    }
    
    func toggle () {
        if Timer.instance.isTimerRunning() {
            Timer.instance.stop()
        } else {
            Timer.instance.go()
        }
    }
    
    func clear () {
        Timer.instance.stop()
        currentTimerState = TimerState.zeroState()
    }
    
    func modifyTime (time: CFTimeInterval) {
        let newTime = currentTimerState.timerValue + time
        currentTimerState = TimerState.newState(newTime, direction: currentTimerState.direction, isRunning: Timer.instance.isTimerRunning())
    }
    
    func changeTimerDirection () {
        if (currentTimerState.direction == TimerDirection.Up) {
            currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: TimerDirection.Down, isRunning: Timer.instance.isTimerRunning())
        } else {
            currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: TimerDirection.Up, isRunning: Timer.instance.isTimerRunning())
        }
    }
    
    func setTimerToDirection(direction: TimerDirection) {
        currentTimerState = TimerState.newState(currentTimerState.timerValue, direction: direction, isRunning: Timer.instance.isTimerRunning())
    }
    
    func returningFromBackground () {
        
        foregrounding = true
        
        if let archive = TimerStateArchive.retrieveTimerState() {
            
            if (archive.isRunning == false) {
                currentTimerState = TimerState.newState(archive.timerValue, direction: archive.direction, isRunning: archive.isRunning)
                return
            }
            
            let timerValue = archive.timerValue!
            let timeSinceBackground = NSDate().timeIntervalSinceDate(archive.timeStamp!)
            let timeLeftOnTimer = currentTimerValue(timerValue, timeDelta: timeSinceBackground, direction: archive.direction)
            
            currentTimerState = TimerState.newState(timeLeftOnTimer, direction: archive.direction, isRunning: archive.isRunning)
            
        } else {
            currentTimerState = TimerState.zeroState()
        }
        
        if (currentTimerState.isRunning == true) {
            Timer.instance.go()
        }
        
    }
    
    func enteringBackground () {
        TimerStateArchive.archiveTimerState(TimerState.newState(currentTimerState.timerValue, direction: currentTimerState.direction, isRunning: Timer.instance.isTimerRunning()))
        Timer.instance.stop()
    }
    
    func subscribeToTimerUpdates (subscriber: TimerManagerDelegate) {
        self.subscribers.append(subscriber)
    }
    
    private func currentTimerValue(timerValue: CFTimeInterval, timeDelta: CFTimeInterval, direction: TimerDirection) -> CFTimeInterval {
        var newTimerValue: CFTimeInterval
        if (direction == .Up) {
            newTimerValue = timerValue + timeDelta
        } else {
            newTimerValue = timerValue - timeDelta
        }
        return newTimerValue
    }
    
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
        let timerValue = currentTimerValue(currentTimerState.timerValue, timeDelta: timeDelta, direction: currentTimerState.direction)
        currentTimerState = TimerState.newState(timerValue, direction: currentTimerState.direction, isRunning: Timer.instance.isTimerRunning())
    }
    
}