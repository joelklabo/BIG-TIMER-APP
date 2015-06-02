//
//  InfoButton.swift
//  Big Timer
//
//  Created by Joel Klabo on 6/1/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class InfoButton: UIView {
    
    @IBInspectable var lineColor: UIColor = UIColor.blueColor()
    @IBInspectable var lineWidth: CGFloat = 3.0
    
    override func drawRect(rect: CGRect) {
        
        let secondHandGap: CGFloat = lineWidth * 3
        let dotGap: CGFloat = lineWidth * 4
        
        // Draw outer circle
        let insetRect = CGRectInset(rect, 30, 30)
        let offsetRect = CGRectOffset(insetRect, 30 - (lineWidth/2), 30 - (lineWidth/2))
        var rect = offsetRect
        var path = UIBezierPath(ovalInRect: rect)
        path.lineWidth = lineWidth
        lineColor.setStroke()
        path.stroke()
        
        // Draw second hand
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        var secondHandPath = UIBezierPath()
        secondHandPath.moveToPoint(center)
        secondHandPath.addLineToPoint(CGPointMake(center.x, CGRectGetMaxY(rect) - secondHandGap))
        
        secondHandPath.lineWidth = lineWidth
        secondHandPath.lineCapStyle = kCGLineCapRound
        secondHandPath.stroke()
        
        // Draw dot of the 'i'
        let dotPosition = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect) + secondHandGap)
        var dotPoint = UIBezierPath()
        dotPoint.moveToPoint(dotPosition)
        dotPoint.addLineToPoint(CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect) + secondHandGap))
        
        dotPoint.lineWidth = lineWidth
        dotPoint.lineCapStyle = kCGLineCapRound
        dotPoint.stroke()
        
    }
    
}