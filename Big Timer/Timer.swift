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
        case Stop
        case Go
    }
    
    var delegate: TimerDelegate?
    
    static let instance = Timer()
    
    lazy private var timeMachine = CADisplayLink()

    private var action: Actions = .Stop {
        willSet (newAction) {
            if newAction == .Stop {
                timeMachine.paused = true
            } else {
                timeMachine.paused = false
            }
        }
    }
    
    init() {
        timeMachine = CADisplayLink(target: self, selector: #selector(Timer.tick))
        timeMachine.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        timeMachine.paused = true
    }
    
    @objc func tick() {
        delegate?.tick(timeMachine.duration)
    }
    
    func isTimerRunning() -> Bool {
        return !timeMachine.paused
    }
    
    func stop() {
        action = .Stop
    }
    
    func go() {
        action = .Go
    }
    
    func toggle() {
        isTimerRunning() ? stop() : go()
    }
    
    private func act(action: Actions) {
        switch action {
        case .Go:
            timeMachine.paused = false
        case .Stop:
            timeMachine.paused = true
        }
    }
    
}

protocol TimerDelegate {
    func tick(timePassed: CFTimeInterval)
}