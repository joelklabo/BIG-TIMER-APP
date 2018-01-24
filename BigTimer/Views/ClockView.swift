//
//  ClockView.swift
//  BigTimer
//
//  Created by Joel Klabo on 1/23/18.
//  Copyright © 2018 Joel Klabo. All rights reserved.
//

import UIKit

class ClockView: UIView {

    let zRotationKeyPath = "transform.rotation.z"
    var lineWidth = Theme.lineWidth()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
            
            // Draw outer circle
            Theme.fillColor().setFill()
            
            let path = UIBezierPath(ovalIn: rect)
            path.lineWidth = lineWidth
            path.fill()
            
            context.setBlendMode(.destinationOut)
            
            // Draw second hand
            
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let secondHandPath = UIBezierPath()
            secondHandPath.move(to: center)
            secondHandPath.addLine(to: CGPoint(x: rect.midX, y: (rect.maxY / 4)))
            secondHandPath.lineWidth = lineWidth
            secondHandPath.lineCapStyle = .round
            secondHandPath.stroke()
        }
    }
    
    func rotateToTime (_ time: TimeInterval) {
        let subSeconds = time.truncatingRemainder(dividingBy: 1)
        let angle = CGFloat((2 * Double.pi) * subSeconds)
        self.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    func reset () {
        self.layer.setValue(CGFloat(0), forKeyPath: zRotationKeyPath)
    }

}
