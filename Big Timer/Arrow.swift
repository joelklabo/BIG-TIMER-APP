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
    
    var lineColor = Theme.lineColor
    var lineWidth = Theme.lineWidth
    
    private var arrowDirection: TimerDirection = .Up
    
    override func draw(_ rect: CGRect) {
        
        lineColor.setStroke()

        let rect = rect.insetBy(dx: lineWidth, dy: lineWidth)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))

        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.stroke()
        
    }
    
    func changeDirection (direction: TimerDirection) {
        
        if (arrowDirection == direction) {
            return
        } else {
            arrowDirection = direction
        }
        
        if (arrowDirection == .Up) {
            self.transform = CGAffineTransform(rotationAngle: 0)
            let rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
            rotateAnimation.duration = 0.2
            rotateAnimation.fromValue = Double.pi
            rotateAnimation.toValue = 0
            self.layer.add(rotateAnimation, forKey: "rotation")
        } else {
            self.layer.setValue(Double.pi, forKey: zRotationKeyPath)
            self.transform = CGAffineTransform(rotationAngle: 3.14)
            let rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
            rotateAnimation.duration = 0.2
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = Double.pi
            self.layer.add(rotateAnimation, forKey: "rotation")
        }
        
    }
    
}
