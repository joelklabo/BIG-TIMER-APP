//
//  Arrow.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/28/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class Arrow: UIView {
    
    let zRotationKeyPath = "transform.rotation.z"
    
    var lineColor = Theme.lineColor()
    var lineWidth = Theme.lineWidth()
    
    private var arrowDirection: TimerDirection = .Up
    
    override func drawRect(rect: CGRect) {
        
        lineColor.setStroke()

        let rect = CGRectInset(rect, lineWidth, lineWidth)
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: CGRectGetMidX(rect), y: CGRectGetMaxY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMidX(rect), y: CGRectGetMinY(rect)))
        
        path.addLineToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMidY(rect)))
        path.moveToPoint(CGPoint(x: CGRectGetMidX(rect), y: CGRectGetMinY(rect)))
        path.addLineToPoint(CGPoint(x: CGRectGetMinX(rect), y: CGRectGetMidY(rect)))

        path.lineWidth = lineWidth
        path.lineCapStyle = .Round
        path.lineJoinStyle = .Round
        path.stroke()
        
    }
    
    func changeDirection (direction: TimerDirection) {
        
        if (arrowDirection == direction) {
            return
        } else {
            arrowDirection = direction
        }
        
        if (arrowDirection == .Up) {
            self.transform = CGAffineTransformMakeRotation(0)
            let rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
            rotateAnimation.duration = 0.2
            rotateAnimation.fromValue = M_PI
            rotateAnimation.toValue = 0
            self.layer.addAnimation(rotateAnimation, forKey: "rotation")
        } else {
            self.layer.setValue(M_PI, forKey: zRotationKeyPath)
            self.transform = CGAffineTransformMakeRotation(3.14)
            let rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
            rotateAnimation.duration = 0.2
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = M_PI
            self.layer.addAnimation(rotateAnimation, forKey: "rotation")
        }
        
    }
    
}
