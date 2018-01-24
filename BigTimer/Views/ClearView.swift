//
//  ClearView.swift
//  BigTimer
//
//  Created by Joel Klabo on 1/23/18.
//  Copyright © 2018 Joel Klabo. All rights reserved.
//

import UIKit

class ClearView: UIView {

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
