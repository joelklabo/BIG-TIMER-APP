//
//  TimeLabel.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/26/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

@IBDesignable

class TimeLabel: UILabel {
    
    var panInfoDelegate: PanGestureInfoReceiving?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        numberOfLines = 1
        userInteractionEnabled = true
        adjustsFontSizeToFitWidth = true
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(TimeLabel.verticalPan(_:))))
    }
    
    func verticalPan(sender: AnyObject) {
        let gestureRecognizer = sender as! UIPanGestureRecognizer
        let velocity = -gestureRecognizer.velocityInView(self).y
        let translation = -gestureRecognizer.translationInView(self).y
        panInfoDelegate?.verticalPanInfo(velocity, translation: translation)
    }
}
