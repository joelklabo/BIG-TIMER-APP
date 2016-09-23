//
//  Theme.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    static func lineColor() -> UIColor {
        return UIColor.white
    }
    static func clockLineColor() -> UIColor {
        return Theme.mainAppColor()
    }
    static func infoButtonLineColor() -> UIColor {
        return UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
    }
    static func fillColor() -> UIColor {
        let color = UIColor.white
        return color
    }
    static func lineWidth() -> CGFloat {
        return CGFloat(10)
    }
    static func tvLineWidth() -> CGFloat {
        return CGFloat(28)
    }
    static func infoButtonLineWidth() -> CGFloat {
        return CGFloat(2)
    }
    static func mainAppColor() -> UIColor {
        return UIColor(red:0.95, green:0.31, blue:0.15, alpha:1.0)
    }
}
