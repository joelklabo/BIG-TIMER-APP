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

class TimerController: NSObject, TimerManagerDelegate, TimerDelegate {
    
    enum Direction {
        case Up
        case Down
    }
    
    private var foregrounding = false
    
    var delegate: TimerManagerDelegate?
    
    private var direction: Direction = .Up {
        didSet (direction) {
            print("new direction \(direction)")
        }
    }
    
    private var timeDelta: CFTimeInterval = 0
    
    private var currentTimerState: TimerState = TimerState.zeroState() {
        didSet {
            if (currentTimerState.timerValue < 0) {
                currentTimerState = TimerState.zeroState()
                Timer.instance.stop()
                if (!foregrounding) {
                    delegate?.timerDone()
                }
            }
            delegate?.timerUpdate(self.currentTimerState)
        }
    }
    
    
    override init () {
        super.init()
        Timer.instance.delegate = self
        setupQuickActions()
    }
    
    func setupQuickActions() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(TimerController.fiveMinuteQuickActionTimer), name: "5", object: nil)
        notificationCenter.addObserver(self, selector: #selector(TimerController.twentyMinuteQuickActionTimer), name: "20", object: nil)
        notificationCenter.addObserver(self, selector: #selector(TimerController.countUpQuickAction), name: "0", object: nil)
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
        timeDelta = 0   
        
        // If there is no active timer session. Don't retrieve the timer state.
        if let archive = TimerStateArchive.retrieveTimerState() {
            
            guard archive.isRunning.boolValue else { return }
            
            let timerValue = archive.timerValue!
            let timeSinceBackgrounded = NSDate().timeIntervalSinceDate(archive.timeStamp!)
            let timeLeftOnTimer = currentTimerValue(timerValue, timeDelta: timeSinceBackgrounded, direction: archive.direction)
            print("Timer Value: \(timerValue) Time Since Backgrounded: \(timeSinceBackgrounded) Time Left:\(timeLeftOnTimer)")
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
    
    private func currentTimerValue(timerValue: CFTimeInterval, timeDelta: CFTimeInterval, direction: TimerDirection) -> CFTimeInterval {
        var newTimerValue: CFTimeInterval = 0
        if (direction == .Up) {
            newTimerValue = timerValue + timeDelta
        } else {
            newTimerValue = timerValue - timeDelta
        }
        return newTimerValue
    }
    
    func timerUpdate(timerState: TimerState) {
        delegate?.timerUpdate(timerState)
    }
    
    func timerDone() {
        delegate?.timerDone()
    }
    
    private func storeTimerState(timerState: TimerState) {
        TimerStateArchive.archiveTimerState(timerState)
    }
        
    func tick(timeDelta: CFTimeInterval) {
        self.timeDelta = timeDelta
        foregrounding = false
        let timerValue = currentTimerValue(currentTimerState.timerValue, timeDelta: self.timeDelta, direction: currentTimerState.direction)
        currentTimerState = TimerState.newState(timerValue, direction: currentTimerState.direction, isRunning: Timer.instance.isTimerRunning())
    }
    
}

// Quick Actions

extension TimerController {
    func countUpQuickAction() {
        currentTimerState = TimerState.newState(0, direction: .Up, isRunning: Timer.instance.isTimerRunning())
        Timer.instance.go()
    }
    func fiveMinuteQuickActionTimer() {
        currentTimerState = timerStateWithDuration(5)
        Timer.instance.go()
    }
    func twentyMinuteQuickActionTimer() {
        currentTimerState = timerStateWithDuration(20)
        Timer.instance.go()
    }
    private func timerStateWithDuration(minutes: Int) -> TimerState {
        return TimerState.newState(Double(minutes * 60), direction: .Down, isRunning: Timer.instance.isTimerRunning())
    }
}