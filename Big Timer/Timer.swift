//
//  Timer.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/21/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

class Timer: NSObject {

    private var timer: CADisplayLink = CADisplayLink()

    var delegate: TimerDelegate?
    var frameTimestamp: CFTimeInterval = 0
    
    override init () {
        super.init()
        timer = CADisplayLink(target: self, selector: Selector("update"))
        timer.paused = true
        timer.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    func update () {
        
        let currentTime = timer.timestamp
        
        if (frameTimestamp == 0) {
            frameTimestamp = currentTime
            return
        }
        
        let renderTime = currentTime - frameTimestamp
        frameTimestamp = currentTime
        
        self.delegate?.tick(renderTime)
    }
    
    func pauseTimer () {
        timer.paused = true
        frameTimestamp = 0
    }
    
    func startTimer () {
        timer.paused = false
    }
    
    func isPaused () -> Bool {
        return timer.paused
    }
    
    func toggle () {
        timer.paused = timer.paused ? false : true
    }
    
    func resumeWithState (timerState: TimerState) {
        timer.paused = !timerState.isRunning
    }
    
}

@objc protocol TimerDelegate {
    func tick(timeDelta: CFTimeInterval)
}