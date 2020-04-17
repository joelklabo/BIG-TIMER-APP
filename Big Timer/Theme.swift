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
        return .systemRed
    }
    
    static var bigTimerBlue: UIColor {
        return .systemBlue
    }
    
    static var bigTimerYellow: UIColor {
        return .systemYellow
    }
    
    static func mainAppColor(sceneNumber: Int) -> UIColor {
        switch sceneNumber % 3 {
        case 0:
            return bigTimerYellow
        case 1:
            return bigTimerRed
        case 2:
            return bigTimerBlue
        default:
            return bigTimerRed
        }

    }
}
