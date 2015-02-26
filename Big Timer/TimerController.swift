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
    
    private var countingUp = true
    
    private var totalTime:Time = 0.0 {
        didSet(time) {
            if (time < 0) {
                totalTime = 0
            }
        }
    }
    
    override init() {
        super.init()
        timer.delegate = self
    }
    
    func toggleCountingUp () {
        countingUp = true
        timer.toggle()
    }
    
    func toggleCountingDown () {
        countingUp = false
        timer.toggle()
    }
    
    func clear () {
        totalTime = 0
        delegate?.tick(totalTime, totalTime: totalTime)
    }
    
    func tick(timeDelta: Time) {
        countingUp ? countUp(timeDelta) : countDown(timeDelta)
        delegate?.tick(timeDelta, totalTime: totalTime)
    }

    private func countUp (time: Time) {
        totalTime = totalTime + time
    }
    
    private func countDown (time: Time) {
        totalTime = totalTime - time
    }
    
}

protocol TimerControllerDelegate {
    func tick(timeDelta: Time, totalTime: Time)
}