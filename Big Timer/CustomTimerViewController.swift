//
//  CustomTimerViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/26/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

class CustomTimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: TimeLabel?
    
    var timer: CustomTimer?
    let timeFormatter = TimeFormatter(separator: ":")
    
    var timerValue = TimerValue() {
        didSet {
            if let timeLabel = timeLabel {
                let formattedTime = timeFormatter.formatTime(timerValue.time)
                timeLabel.text = formattedTime.formattedString
            }
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "Update Timer"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CustomTimerViewController.save))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel!.text = timeFormatter.formatTime(timerValue.time).formattedString
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(sender:))))
    }
    
    @objc func save() {
        guard let timer = timer else {
            fatalError()
        }
        CustomTimerManager().updateTimer(timer: timer, newValue: Int(timerValue.time))
        navigationController?.popViewController(animated: true)
    }

}

extension CustomTimerViewController: PanGestureInfoReceiving {
    @objc func verticalPanPassthrough(sender: AnyObject) {
        verticalPan(sender: sender)
    }
    func verticalPanInfo(velocity: Double, translation: Double) {
        let timeDelta = TimeDeltaCalculator.timeDeltaFrom(velocity: velocity, translation: translation)
        timerValue.update(timeDelta)
    }
}
