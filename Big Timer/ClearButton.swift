//
//  ClearButton.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/25/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

@IBDesignable

class ClearButton: UIView {
    
    override func drawRect(rect: CGRect) {
        
//        let insetRect = CGRectInset(rect, 25, 25)
//        let offsetRect = CGRectOffset(insetRect, 25 - Theme.lineWidth(), -25 + Theme.lineWidth())
        var rect = rect
        
        let path = UIBezierPath()
        
        rect = CGRectInset(rect, 6, 6)
        
        path.moveToPoint(CGPoint(x: CGRectGetMinX(rect), y: CGRectGetMinY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMaxY(rect)))
        
        path.moveToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMinY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMinX(rect), y: CGRectGetMaxY(rect)))
        
        path.lineWidth = Theme.clearButtonLineWidth()
        path.lineCapStyle = .Round
        Theme.lineColor().setStroke()
        path.stroke()
        
    }
}
