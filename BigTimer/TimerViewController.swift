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
    }
    
    // MARK: Actions
    
    @IBAction func down(_ sender: Any) {
        state.direction = .down
    }
    
    @IBAction func up(_ sender: Any) {
        state.direction = .up
    }

    @IBAction func start(_ sender: Any) {
        state.running = true
    }
    
    @IBAction func stop(_ sender: Any) {
        state.running = false
    }
    
    @IBAction func clear(_ sender: Any) {
        state.running = false
        state.value = 0
    }

    // MARK: TimerSubscribing
    
    func update(_ timestamp: Double) {
        state.update(timestamp)
    }
    



}
