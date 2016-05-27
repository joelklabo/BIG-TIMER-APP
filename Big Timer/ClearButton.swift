//
//  ClearButton.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/25/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ClearButton: UIView {
    
    var lineColor = Theme.lineColor()
    var lineWidth = Theme.lineWidth()
    
    override func drawRect(rect: CGRect) {
        
        var rect = rect
        
        let path = UIBezierPath()
        
        rect = CGRectInset(rect, lineWidth, lineWidth)
        
        path.moveToPoint(CGPoint(x: CGRectGetMinX(rect), y: CGRectGetMinY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMaxY(rect)))
        
        path.moveToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMinY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMinX(rect), y: CGRectGetMaxY(rect)))
        
        path.lineWidth = lineWidth
        path.lineCapStyle = .Round
        lineColor.setStroke()
        path.stroke()
        
    }
}
