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
    
    func addTime(time: Time) {
        timer.pause()
        totalTime = totalTime + time
        delegate?.tick(0, totalTime: totalTime)
        countingUp = false
    }

    func clear () {
        totalTime = 0
        countingUp = true
        timer.pause()
        delegate?.tick(totalTime, totalTime: totalTime)
    }
    
    func toggle () {
        timer.toggle()
    }
    
    func tick(timeDelta: Time) {
        if (countingUp == true) {
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

protocol TimerControllerDelegate {
    func tick(timeDelta: Time, totalTime: Time)
    func done()
}