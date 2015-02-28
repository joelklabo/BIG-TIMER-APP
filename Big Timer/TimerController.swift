//
//  TimerController.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/25/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

class TimerController: NSObject, TimerDelegate {
    
    var delegate: TimerControllerDelegate?
    
    private var timer = Timer()
    
    private var direction: TimerDirection = .Up {
        didSet {
            if (oldValue != direction) {                
                delegate?.directionChange(direction)
            }
        }
    }
    
    private var totalTime:Time = 0 {
        didSet {
            if (totalTime < 0) {
                totalTime = 0
                delegate?.done()
            }
        }
    }
    
    override init() {
        super.init()
        timer.delegate = self
    }
    
    func flipDirection () {
        if (direction == .Up) {
            direction = .Down
        } else {
            direction = .Up
        }
    }
    
    func addTime(time: Time) {
        timer.pause()
        totalTime = totalTime + time
        direction = .Down
        delegate?.tick(0, totalTime: totalTime)
    }

    func clear () {
        timer.pause()
        totalTime = 0
        direction = .Up
        delegate?.tick(totalTime, totalTime: totalTime)
    }
    
    func toggle () {
        timer.toggle()
    }
    
    func tick(timeDelta: Time) {
        if (direction == .Up) {
            countUp(timeDelta)
        } else {
            countDown(timeDelta)
        }
        delegate?.tick(timeDelta, totalTime: totalTime)
    }

    private func countUp (time: Time) {
        totalTime = totalTime + time
    }
    
    private func countDown (time: Time) {
        totalTime = totalTime - time
    }
    
}

enum TimerDirection {
    case Up
    case Down
}

protocol TimerControllerDelegate {
    func tick(timeDelta: Time, totalTime: Time)
    func done()
    func directionChange(direction: TimerDirection)
}