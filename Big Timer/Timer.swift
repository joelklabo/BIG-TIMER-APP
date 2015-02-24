//
//  Timer.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/21/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

typealias Time = (hours: Int,
                minutes: Int,
                seconds: Int,
           milliseconds: Int)

class Timer: NSObject {

    private var time: Time
    private var lastTick: Double
    private var timer: CADisplayLink?
    
    var delegate: TimerUpdateDelegate?
    
    override init () {
        time = (hours: 0, minutes: 0, seconds: 0, milliseconds: 0)
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
        
        let elapsedMilliseconds = Int(round(((elapsedSeconds) * 1000)))
        lastTick = currentTime
        milliTick(elapsedMilliseconds)
    }
    
    private func milliTick (elapsedMilliseconds: Int) {
        
        time.milliseconds += elapsedMilliseconds
        
        if (time.milliseconds >= 1000) {
            time.milliseconds = time.milliseconds % 1000
            time.seconds += 1
            
            if (time.seconds >= 60) {
                time.seconds = time.seconds % 60
                time.minutes += 1
                
                if (time.minutes >= 60) {
                    time.minutes = time.minutes % 60
                    time.hours += 1
                }
            }
            
            delegate?.timeUpdate(time, sync: true)
            
        } else {
            return
        }
        
        
        
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
        timer?.frameInterval = 4
        timer?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        delegate?.timeUpdate(time, sync: false)
    }
    
    func resume () {
        lastTick = 0
        timer?.paused = false
        delegate?.timeUpdate(time, sync: false)
    }
    
    func pause () {
        timer?.paused = true
        delegate?.timeUpdate(time, sync: false)
    }
    
    func reset () {
        timer?.invalidate()
        timer = nil
        lastTick = 0
        time = (hours: 0, minutes: 0, seconds: 0, milliseconds: 0)
        delegate?.timeUpdate(time, sync: true)
    }
}

protocol TimerUpdateDelegate {
    func timeUpdate(time: Time, sync: Bool)
    func tick(timeDelta: Double)
}

