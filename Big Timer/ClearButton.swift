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

    @IBInspectable var lineColor: UIColor = UIColor.blueColor()
    @IBInspectable var lineWidth: CGFloat = 3.0
    
    override func drawRect(rect: CGRect) {
        
        let insetRect = CGRectInset(rect, 25, 25)
        let offsetRect = CGRectOffset(insetRect, 25 - lineWidth, -25 + lineWidth)
        var rect = offsetRect
  
//        var circlePath = UIBezierPath(ovalInRect: rect)
//        circlePath.lineWidth = lineWidth
//        lineColor.setStroke()
//        circlePath.stroke()
        
        let path = UIBezierPath()
        
        rect = CGRectInset(rect, 6, 6)
        
        path.moveToPoint(CGPoint(x: CGRectGetMinX(rect), y: CGRectGetMinY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMaxY(rect)))
        
        path.moveToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMinY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMinX(rect), y: CGRectGetMaxY(rect)))
        
        path.lineWidth = lineWidth
        path.lineCapStyle = kCGLineCapRound
        lineColor.setStroke()
        path.stroke()
        
    }
}
