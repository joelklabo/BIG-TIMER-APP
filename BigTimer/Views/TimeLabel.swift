//
//  TimeLabel.swift
//  BigTimer
//
//  Created by Joel Klabo on 1/23/18.
//  Copyright © 2018 Joel Klabo. All rights reserved.
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
        adjustsFontSizeToFitWidth = true
    }
    
    
}
