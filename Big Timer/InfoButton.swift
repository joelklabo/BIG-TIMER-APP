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
    @IBInspectable var lineWidth: CGFloat = 4.0
    
    override func drawRect(rect: CGRect) {
                
        let inset: CGFloat = 35
        
        // Draw outer circle
        let insetRect = CGRectInset(rect, inset, inset)
        let offsetRect = CGRectOffset(insetRect, -inset + (lineWidth/2), inset - (lineWidth/2))
        let rect = offsetRect
        let path = UIBezierPath(ovalInRect: rect)
        path.lineWidth = lineWidth
        lineColor.setStroke()
        path.stroke()
        
        // Draw the line of the 'i'
        let center = CGPointMake(CGRectGetMidX(rect), (CGRectGetMidY(rect) - lineWidth))
        let secondHandPath = UIBezierPath()
        secondHandPath.moveToPoint(CGPointMake(center.x, center.y + lineWidth))
        secondHandPath.addLineToPoint(CGPointMake(center.x, CGRectGetMaxY(rect) - (lineWidth * 3)))
        
        secondHandPath.lineWidth = lineWidth
        secondHandPath.lineCapStyle = .Round
        secondHandPath.stroke()
        
        // Draw dot of the 'i'
        let dotPosition = CGPointMake(CGRectGetMidX(rect), (CGRectGetMinY(rect) + (lineWidth * 4)))
        let dotPoint = UIBezierPath()
        dotPoint.moveToPoint(dotPosition)
        dotPoint.addLineToPoint(dotPosition)
        
        dotPoint.lineWidth = lineWidth + 1
        dotPoint.lineCapStyle = .Round
        dotPoint.stroke()
        
    }
    
}