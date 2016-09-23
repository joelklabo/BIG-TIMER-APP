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
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        numberOfLines = 1
        isUserInteractionEnabled = true
        adjustsFontSizeToFitWidth = true
        
        font = UIFont.monospacedDigitSystemFont(ofSize: font.pointSize, weight: UIFontWeightMedium)
    }
    

}
