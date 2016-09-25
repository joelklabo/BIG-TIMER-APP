//
//  InfoButton.swift
//  Big Timer
//
//  Created by Joel Klabo on 6/1/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

class InfoButton: UIView {
    
    var lineColor = Theme.lineColor()
    var lineWidth = Theme.lineWidth()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
        }
        
        let rect = rect.insetBy(dx: lineWidth, dy: lineWidth)
        
        let offset: CGFloat = 18.0
        let dotLength: CGFloat = 2
        
        let path = UIBezierPath()
        
        // First
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + dotLength, y: rect.minY))
        
        path.move(to: CGPoint(x: rect.minX + offset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        
        // Second
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + dotLength, y: rect.midY))
        
        path.move(to: CGPoint(x: rect.minX + offset, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        // Third
        path.move(to: CGPoint(x: rect.minX, y: rect.maxX))
        path.addLine(to: CGPoint(x: rect.minX + dotLength, y: rect.maxX))
        
        path.move(to: CGPoint(x: rect.minX + offset, y: rect.maxX))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        lineColor.setStroke()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.stroke()
        
    }
    
}
