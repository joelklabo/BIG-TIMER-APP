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
    var lineWidth = Theme.lineWidth
    
    override func draw(_ rect: CGRect) {
        
        // Draw outer circle
        Theme.fillColor.setFill()

        let path = UIBezierPath(ovalIn: rect)
        path.lineWidth = lineWidth
        path.fill()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let secondHandPath = UIBezierPath()
        secondHandPath.move(to: center)
        secondHandPath.addLine(to: CGPoint(x: rect.midX, y: (rect.maxY / 4)))
        secondHandPath.lineWidth = lineWidth
        secondHandPath.lineCapStyle = .round
        secondHandPath.stroke(with: .clear, alpha: 0)
    }
    
    func rotateToTime (time: TimeInterval) {
        let subSeconds = time.truncatingRemainder(dividingBy: 1)
        let angle = CGFloat((2 * Double.pi) * subSeconds)
        self.transform = CGAffineTransform(rotationAngle: angle)
    }

    func reset () {
        self.layer.setValue(CGFloat(0), forKeyPath: zRotationKeyPath)
    }
    
}
