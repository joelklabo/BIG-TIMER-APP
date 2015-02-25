//
//  Timer.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/21/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

typealias Time = Double

class Timer: NSObject {

    private var lastTick: Double
    private var timer: CADisplayLink?
    
    var delegate: TimerUpdateDelegate?
    
    override init () {
        lastTick = 0
    }
    
    func update () {
        
        if (lastTick == 0) {
            lastTick = CACurrentMediaTime()
            return
        }
        
        let currentTime = CACurrentMediaTime()
        let elapsedSeconds = currentTime - lastTick
        delegate?.tick(elapsedSeconds)
        lastTick = currentTime
    }
    
    func toggle () {
        if let paused = timer?.paused {
            if (paused) {
                resume()
            } else {
                pause()
            }
        } else {
            start()
        }
    }
    
    func start () {
        timer = CADisplayLink(target: self, selector: Selector("update"))
        timer?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    func resume () {
        lastTick = 0
        timer?.paused = false
    }
    
    func pause () {
        timer?.paused = true
    }
    
    func reset () {
        timer?.invalidate()
        timer = nil
        lastTick = 0
    }
}

protocol TimerUpdateDelegate {
    func tick(timeDelta: Time)
}

