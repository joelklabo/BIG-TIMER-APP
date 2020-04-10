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
    
    static var clockLineColor: UIColor {
        return Theme.mainAppColor
    }
    
    static var infoButtonLineColor: UIColor {
        return UIColor.white
    }
    
    static var fillColor: UIColor {
        return UIColor.white
    }
    
    static var lineWidth: CGFloat {
        return CGFloat(8)
    }
    
    static var tvLineWidth: CGFloat {
        return CGFloat(28)
    }
    
    static var infoButtonLineWidth: CGFloat {
        return CGFloat(2)
    }
    
    static var clearButtonLineWidth: CGFloat {
        return CGFloat(8)
    }
    
    static var arrowrButtonLineWidth: CGFloat {
        return CGFloat(8)
    }
    
    static var mainAppColor: UIColor {
        return UIColor(red: 221/255, green: 35/255, blue: 0, alpha: 1)
    }
}
