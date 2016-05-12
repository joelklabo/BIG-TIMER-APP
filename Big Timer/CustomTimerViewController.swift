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
                timeLabel.text = formattedTime.timeString
            }
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "Change Custom Timer"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(CustomTimerViewController.save))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel!.text = timeFormatter.formatTime(timerValue.time).timeString
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(_:))))
    }
    
    func save() {
        guard let timer = timer else {
            fatalError()
        }
        CustomTimerManager().updateTimer(timer, newValue: Int(timerValue.time))
        navigationController?.popViewControllerAnimated(true)
    }

}

extension CustomTimerViewController: PanGestureInfoReceiving {
    func verticalPanPassthrough(sender: AnyObject) {
        verticalPan(sender)
    }
    func verticalPanInfo(velocity: CGFloat, translation: CGFloat) {
        let timeDelta = TimeDeltaCalculator.timeDeltaFrom(velocity, translation: translation)
        timerValue.update(timeDelta)
    }
}
