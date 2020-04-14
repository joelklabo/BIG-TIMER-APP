//
//  Theme.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

struct Theme {
    
    static var lineColor: UIColor {
        return UIColor.white
    }
    
    static var infoButtonLineColor: UIColor {
        return UIColor.white
    }
    
    static var fillColor: UIColor {
        return UIColor.white
    }
    
    static var lineWidth: CGFloat {
        return CGFloat(10)
    }
    
    static var tvLineWidth: CGFloat {
        return CGFloat(28)
    }
    
    static var infoButtonLineWidth: CGFloat {
        return CGFloat(2)
    }
    
    static var clearButtonLineWidth: CGFloat {
        return CGFloat(10)
    }
    
    static var arrowrButtonLineWidth: CGFloat {
        return CGFloat(10)
    }
    
    static var bigTimerRed: UIColor {
        // #dd3700
        return UIColor(red: 221/255, green: 35/255, blue: 0, alpha: 1)
    }
    
    static var bigTimerBlue: UIColor {
        // #dd3700
        return UIColor(red: 0/255, green: 0/255, blue: 255, alpha: 1)
    }
    
    static func mainAppColor(sceneNumber: Int) -> UIColor {
        switch sceneNumber {
        case 1:
            return bigTimerRed
        case 2:
            return bigTimerBlue
        default:
            return UIColor(red: 221/255, green: 35/255, blue: 0, alpha: 1)
        }

    }
}
