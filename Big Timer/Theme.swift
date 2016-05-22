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
        return UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    static func clockLineColor() -> UIColor {
        return UIColor(colorLiteralRed: 221/255, green: 73/255, blue: 46/255, alpha: 1)
    }
    static func infoButtonLineColor() -> UIColor {
        return UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
    }
    static func fillColor() -> UIColor {
        return UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    static func lineWidth() -> CGFloat {
        return CGFloat(8)
    }
    static func infoButtonLineWidth() -> CGFloat {
        return CGFloat(2)
    }
    static func clearButtonLineWidth() -> CGFloat {
        return CGFloat(8)
    }
    static func arrowrButtonLineWidth() -> CGFloat {
        return CGFloat(8)
    }
}