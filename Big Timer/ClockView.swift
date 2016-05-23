//
//  ClockView.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/20/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    let zRotationKeyPath = "transform.rotation.z"
    
    override func drawRect(rect: CGRect) {
        
        // Draw outer circle
        Theme.fillColor().setFill()

        let insetRect = CGRectInset(rect, (Theme.lineWidth()/2), (Theme.lineWidth()/2))
        let path = UIBezierPath(ovalInRect: insetRect)
        path.lineWidth = Theme.lineWidth()
        path.fill()
        
        // Draw second hand
        Theme.clockLineColor().setStroke()
        
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let secondHandPath = UIBezierPath()
        secondHandPath.moveToPoint(center)
        secondHandPath.addLineToPoint(CGPointMake(CGRectGetMidX(rect), (CGRectGetMaxY(rect) / 3.5)))
        secondHandPath.lineWidth = Theme.lineWidth()
        secondHandPath.lineCapStyle = .Round
        secondHandPath.stroke()
    }
    
    func rotateToTime (time: NSTimeInterval) {
        let subSeconds = time % 1
        let angle = CGFloat((2 * M_PI) * subSeconds)
        self.transform = CGAffineTransformMakeRotation(angle)
    }

    func reset () {
        self.layer.setValue(CGFloat(0), forKeyPath: zRotationKeyPath)
    }
    
}