//
//  ClearButton.swift
//  Big Timer
//
//  Created by Joel Klabo on 2/25/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

class ClearButton: UIView {
    
    var lineColor = Theme.lineColor()
    var lineWidth = Theme.lineWidth()
    
    override func draw(_ rect: CGRect) {
        
        var rect = rect
        
        let path = UIBezierPath()
        
        rect = rect.insetBy(dx: lineWidth, dy: lineWidth)
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        lineColor.setStroke()
        path.stroke()
        
    }
}
