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
    
    override func drawRect(rect: CGRect) {
                
        let inset: CGFloat = 35
        
        // Draw outer circle
        let insetRect = CGRectInset(rect, inset, inset)
        let offsetRect = CGRectOffset(insetRect, -inset + (Theme.infoButtonLineWidth()/2), inset - (Theme.infoButtonLineWidth()/2))
        let rect = offsetRect
        let path = UIBezierPath(ovalInRect: rect)
        path.lineWidth = Theme.infoButtonLineWidth()
        Theme.infoButtonLineColor().setStroke()
        path.stroke()
        
        // Draw the line of the 'i'
        let center = CGPointMake(CGRectGetMidX(rect), (CGRectGetMidY(rect) - Theme.infoButtonLineWidth()))
        let secondHandPath = UIBezierPath()
        secondHandPath.moveToPoint(CGPointMake(center.x, center.y + Theme.infoButtonLineWidth()))
        secondHandPath.addLineToPoint(CGPointMake(center.x, CGRectGetMaxY(rect) - (Theme.infoButtonLineWidth() * 3)))
        
        secondHandPath.lineWidth = Theme.infoButtonLineWidth()
        secondHandPath.lineCapStyle = .Round
        secondHandPath.stroke()
        
        // Draw dot of the 'i'
        let dotPosition = CGPointMake(CGRectGetMidX(rect), (CGRectGetMinY(rect) + (Theme.infoButtonLineWidth() * 4)))
        let dotPoint = UIBezierPath()
        dotPoint.moveToPoint(dotPosition)
        dotPoint.addLineToPoint(dotPosition)
        
        dotPoint.lineWidth = Theme.infoButtonLineWidth() + 1
        dotPoint.lineCapStyle = .Round
        dotPoint.stroke()
        
    }
    
}