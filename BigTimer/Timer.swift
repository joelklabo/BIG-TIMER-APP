//
//  Timer.swift
//  BigTimer
//
//  Created by Joel Klabo on 3/22/17.
//  Copyright © 2017 Joel Klabo. All rights reserved.
//

import Foundation
import QuartzCore

protocol TimerSubscribing {
    func update(_ timestamp: Double)
}

fileprivate protocol TimerResponderDelegate {
    func update(_: CADisplayLink)
}

final class Timer {
    
    private class TimerResponder: NSObject {
        var delegate: TimerResponderDelegate?
        @objc func update(_ link: CADisplayLink) {
            delegate?.update(link)
        }
    }
    
    private class BaseTimer: TimerResponderDelegate {
        
        var delegate: TimerSubscribing?
        
        private let responder = TimerResponder()
        private var displayLink: CADisplayLink?
        private var delegateBlock: ((_ time: Double) -> ())?
        
        private var time: Double = 0 {
            didSet {
                delegateBlock?(time)
            }
        }
        
        init(_ block: @escaping ((_ time: Double) -> ())) {
            delegateBlock = block
            responder.delegate = self
            displayLink = CADisplayLink(target: responder, selector: #selector(responder.update))
            displayLink?.add(to: RunLoop.current, forMode: .commonModes)
        }
        
        func update(_ link: CADisplayLink) {
            time = link.timestamp
        }
        
        deinit {
            displayLink?.invalidate()
        }
    }
    
    static let shared = Timer()
    
    private var timer: BaseTimer?
    private var subscribers = [TimerSubscribing]()
    
    init() {
        timer = BaseTimer { [weak self] time in
            guard let strongSelf = self else { return }
            for (_, subscriber) in strongSelf.subscribers.enumerated() {
                subscriber.update(time)
            }
        }
    }
    
    func subscribe(_ subscriber: TimerSubscribing) {
        subscribers.append(subscriber)
    }
}
