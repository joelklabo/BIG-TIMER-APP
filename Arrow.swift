//
//  Arrow.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

@IBDesignable

class Arrow: UIView {
    
    let zRotationKeyPath = "transform.rotation.z"
    
    @IBInspectable var lineColor: UIColor = UIColor.blueColor()
    @IBInspectable var lineWidth: CGFloat = 3.0
    
    private var arrowDirection: TimerDirection = .Up
    
    override func drawRect(rect: CGRect) {
        
        lineColor.setStroke()

        let rect = CGRectInset(rect, 3, 3)
        
        var path = UIBezierPath()
        path.moveToPoint(CGPoint(x: CGRectGetMidX(rect), y: CGRectGetMaxY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMidX(rect), y: CGRectGetMinY(rect)))
        
        path.addLineToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMidY(rect)))
        path.moveToPoint(CGPoint(x: CGRectGetMidX(rect), y: CGRectGetMinY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMinX(rect), y: CGRectGetMidY(rect)))

        path.lineWidth = lineWidth
        path.lineCapStyle = kCGLineCapRound
        path.lineJoinStyle = kCGLineJoinRound
        path.stroke()
        
    }
    
    func changeDirection (direction: TimerDirection) {
        
        if (arrowDirection == direction) {
            return
        }
        
        if (direction == .Up) {
            self.layer.setValue(0, forKey: zRotationKeyPath)
            var rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
            rotateAnimation.duration = 0.1
            rotateAnimation.fromValue = M_PI
            rotateAnimation.toValue = 0
            self.layer.addAnimation(rotateAnimation, forKey: "rotation")
        } else {
            self.layer.setValue(M_PI, forKey: zRotationKeyPath)
            var rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
            rotateAnimation.duration = 0.1
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = M_PI
            self.layer.addAnimation(rotateAnimation, forKey: "rotation")
        }
        
    }
    
}
