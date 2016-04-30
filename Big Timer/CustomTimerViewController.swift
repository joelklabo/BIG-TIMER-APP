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
    
    var timerInfo: Int?

    let timeFormatter = TimeFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.panInfoDelegate = self
        timeLabel.text = String(timeFormatter.formatTime(timerInfo!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CustomTimerViewController: PanGestureInfoReceiving {
    func verticalPanInfo(velocity: CGFloat, translation: CGFloat) {
        print("panning")
    }
}
