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
        let dotGap: CGFloat = lineWidth * 5
        
        let inset: CGFloat = 35
        
        // Draw outer circle
        let insetRect = CGRectInset(rect, inset, inset)
        let offsetRect = CGRectOffset(insetRect, -inset + (lineWidth/2), inset - (lineWidth/2))
        var rect = offsetRect
        var path = UIBezierPath(ovalInRect: rect)
        path.lineWidth = lineWidth
        lineColor.setStroke()
        path.stroke()
        
        // Draw second hand
        let center = CGPointMake(CGRectGetMidX(rect), (CGRectGetMidY(rect) - lineWidth))
        var secondHandPath = UIBezierPath()
        secondHandPath.moveToPoint(center)
        secondHandPath.addLineToPoint(CGPointMake(center.x, CGRectGetMaxY(rect) - (lineWidth * 4)))
        
        secondHandPath.lineWidth = 3.5
        secondHandPath.lineCapStyle = kCGLineCapRound
        secondHandPath.stroke()
        
        // Draw dot of the 'i'
        let dotPosition = CGPointMake(CGRectGetMidX(rect), (CGRectGetMinY(rect) + (lineWidth * 4)))
        var dotPoint = UIBezierPath()
        dotPoint.moveToPoint(dotPosition)
        dotPoint.addLineToPoint(dotPosition)
        
        dotPoint.lineWidth = 3.5
        dotPoint.lineCapStyle = kCGLineCapRound
        dotPoint.stroke()
        
    }
    
}