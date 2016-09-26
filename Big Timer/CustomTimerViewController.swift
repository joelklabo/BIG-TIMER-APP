//
//  CustomTimerViewController.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/26/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

class CustomTimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: TimeLabel!
    
    var timer: CustomTimer?
    let timeFormatter = TimeFormatter(separator: ":")
    
    var timerValue = Double() {
        didSet {
            if timerValue < 0 {
                timerValue = 0
            }
            if let timeLabel = timeLabel {
                let formattedTime = timeFormatter.formatTime(time: timerValue)
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
        colorChangeDidOccur()
        timeLabel.text = timeFormatter.formatTime(time: timerValue).formattedString
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalPanPassthrough(_:))))
        NotificationCenter.default.addObserver(self, selector: #selector(CustomTimerViewController.colorChangeDidOccur), name: ColorSettingController().colorChangeNotificationKey, object: nil)
    }
    
    func save() {
        guard let timer = timer else { fatalError() }
        CustomTimerManager().updateTimer(timer, newValue: timerValue)
        let _ = navigationController?.popViewController(animated: true)
    }

}

extension CustomTimerViewController: ColorChangeDelegate {
    func colorChangeDidOccur() {
        self.view.backgroundColor = ColorSettingController().selectedColor()
    }
}

extension CustomTimerViewController: PanGestureInfoReceiving {
    func verticalPanPassthrough(_ sender: AnyObject) {
        verticalPan(sender)
    }
    func verticalPanInfo(_ velocity: CGFloat, translation: CGFloat) {
        let timeDelta = TimeDeltaCalculator.timeDeltaFrom(velocity, translation: translation)
        timerValue = timerValue + timeDelta
    }
}
