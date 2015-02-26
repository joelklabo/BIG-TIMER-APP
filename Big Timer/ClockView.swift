//
//  ClockView.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/20/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

@IBDesignable

class ClockView: UIView {
    
    @IBInspectable var lineColor: UIColor = UIColor.blueColor()
    @IBInspectable var lineWidth: CGFloat = 3.0
    
    let zRotationKeyPath = "transform.rotation.z"
    var stopAnimation = false
    
    override func drawRect(rect: CGRect) {
        
        let secondHandGap: CGFloat = lineWidth * 4
        
        // Draw outer circle
        let insetRect = CGRectInset(rect, (lineWidth/2), (lineWidth/2))
        var path = UIBezierPath(ovalInRect: insetRect)
        path.lineWidth = lineWidth
        lineColor.setStroke()
        path.stroke()
        
        // Draw second hand
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        var secondHandPath = UIBezierPath()
        secondHandPath.moveToPoint(center)
        secondHandPath.addLineToPoint(CGPointMake(center.x, CGRectGetMinY(rect) + secondHandGap))
        secondHandPath.lineWidth = lineWidth
        secondHandPath.lineCapStyle = kCGLineCapRound
        secondHandPath.stroke()
    }
    
    func rotate (timeDelta: Double) {
                
        let angleToAdd = CGFloat((2 * M_PI) * timeDelta)
        let currentAngle = self.layer.valueForKeyPath(zRotationKeyPath) as CGFloat
        let newAngle = currentAngle + angleToAdd
        
        self.layer.setValue(newAngle, forKeyPath: zRotationKeyPath)
        
        var rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
        
        rotateAnimation.duration = timeDelta
        rotateAnimation.additive = true
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.toValue = 0.0
        rotateAnimation.byValue = angleToAdd
        rotateAnimation.delegate = self
        
        self.layer.addAnimation(rotateAnimation, forKey: "rotation")
    }

    func reset () {
        self.layer.setValue(CGFloat(0), forKeyPath: zRotationKeyPath)
    }
    
}