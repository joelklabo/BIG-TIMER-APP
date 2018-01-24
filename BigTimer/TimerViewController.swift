//
//  TimerViewController.swift
//  BigTimer
//
//  Created by Joel Klabo on 3/22/17.
//  Copyright © 2017 Joel Klabo. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, TimerSubscribing {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var arrowView: ArrowView!
    @IBOutlet weak var clockView: ClockView!
    
    private var state = TimerState() {
        didSet {
            updateWith(state)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.shared.subscribe(self)
    }
    
    private func updateWith(_ state: TimerState) {
        label.text = "\(state.value)"
        arrowView.changeDirection(state.direction)
        clockView.rotateToTime(state.value)
    }
    
    // MARK: Actions
    
    @IBAction func clockTap(_ sender: Any) {
        state.running = !state.running
    }
    
    @IBAction func ArrowTap(_ sender: Any) {
        if state.direction == .up {
            state.direction = .down
        } else {
            state.direction = .up
        }
    }

    @IBAction func clearTap(_ sender: Any) {
        state.running = false
        state.value = 0
    }

    // MARK: TimerSubscribing
    
    func update(_ timestamp: Double) {
        state.update(timestamp)
    }

}
