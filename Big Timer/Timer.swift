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
                timeMachine.isPaused = true
            } else {
                timeMachine.isPaused = false
            }
        }
    }
    
    init() {
        timeMachine = CADisplayLink(target: self, selector: #selector(Timer.tick))
        timeMachine.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
        timeMachine.isPaused = true
    }
    
    @objc func tick() {
        delegate?.tick(timePassed: timeMachine.duration)
    }
    
    func isTimerRunning() -> Bool {
        return !timeMachine.isPaused
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
            timeMachine.isPaused = false
        case .Stop:
            timeMachine.isPaused = true
        }
    }
    
}

protocol TimerDelegate {
    func tick(timePassed: Double)
}
