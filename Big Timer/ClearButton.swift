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
        
        let insetRect = CGRectInset(rect, (lineWidth * 2), (lineWidth * 2))
        var path = UIBezierPath()
        
        path.moveToPoint(CGPoint(x: CGRectGetMinX(insetRect), y: CGRectGetMinY(insetRect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMaxX(insetRect), y: CGRectGetMaxX(insetRect)))
        
        path.moveToPoint(CGPoint(x: CGRectGetMaxX(insetRect), y: CGRectGetMinY(insetRect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMinX(insetRect), y: CGRectGetMaxY(insetRect)))
        
        path.lineWidth = lineWidth
        path.lineCapStyle = kCGLineCapRound
        lineColor.setStroke()
        path.stroke()
        
    }
}
