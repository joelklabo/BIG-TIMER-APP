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
    
    override func draw(_ rect: CGRect) {
                
        let inset: CGFloat = 35
        
        // Draw outer circle
        let insetRect = rect.insetBy(dx: inset, dy: inset)
        let offsetRect = insetRect.offsetBy(dx: -inset + (Theme.infoButtonLineWidth/2), dy: inset - (Theme.infoButtonLineWidth/2))
        let rect = offsetRect
        let path = UIBezierPath(ovalIn: rect)
        path.lineWidth = Theme.infoButtonLineWidth
        Theme.infoButtonLineColor.setStroke()
        path.stroke()
        
        // Draw the line of the 'i'
        let center = CGPoint(x: rect.midX, y: (rect.midY - Theme.infoButtonLineWidth))
        let secondHandPath = UIBezierPath()
        secondHandPath.move(to: CGPoint(x: center.x, y: center.y + Theme.infoButtonLineWidth))
        secondHandPath.addLine(to: CGPoint(x: center.x, y: rect.maxY - (Theme.infoButtonLineWidth * 3)))
        
        secondHandPath.lineWidth = Theme.infoButtonLineWidth
        secondHandPath.lineCapStyle = .round
        secondHandPath.stroke()
        
        // Draw dot of the 'i'
        let dotPosition = CGPoint(x: rect.midX, y: (rect.minY + (Theme.infoButtonLineWidth * 4)))
        let dotPoint = UIBezierPath()
        dotPoint.move(to: dotPosition)
        dotPoint.addLine(to: dotPosition)
        
        dotPoint.lineWidth = Theme.infoButtonLineWidth + 1
        dotPoint.lineCapStyle = .round
        dotPoint.stroke()
        
    }
    
}
