//
//  TimerX.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/23/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

class Timer {
    
    enum Actions {
        case stop
        case go
    }
    
    var delegate: TimerDelegate?
    
    static let instance = Timer()
    
    lazy fileprivate var timeMachine = CADisplayLink()

    fileprivate var action: Actions = .stop {
        willSet (newAction) {
            if newAction == .stop {
                timeMachine.isPaused = true
            } else {
                timeMachine.isPaused = false
            }
        }
    }
    
    init() {
        timeMachine = CADisplayLink(target: self, selector: #selector(Timer.tick))
        timeMachine.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        timeMachine.isPaused = true
    }
    
    @objc func tick() {
        delegate?.tick(timeMachine.duration)
    }
    
    func isTimerRunning() -> Bool {
        return !timeMachine.isPaused
    }
    
    func stop() {
        action = .stop
    }
    
    func go() {
        action = .go
    }
    
    func toggle() {
        isTimerRunning() ? stop() : go()
    }
    
    fileprivate func act(_ action: Actions) {
        switch action {
        case .go:
            timeMachine.isPaused = false
        case .stop:
            timeMachine.isPaused = true
        }
    }
    
}

protocol TimerDelegate {
    func tick(_ timePassed: CFTimeInterval)
}
