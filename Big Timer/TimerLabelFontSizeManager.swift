//
//  TimerLabelFontSizeManager.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/12/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

struct TimerLabelFontSizeManager {
    
    static func sizeFor(traits: UITraitCollection) -> CGFloat {
        let width = traits.horizontalSizeClass
        let height = traits.verticalSizeClass
        let scale = traits.displayScale
        switch (width, height, scale) {
        // iPhone Landscape, iPhone, iPhone 6 Portrait
        case (.Compact, .Compact, 2.0), (.Compact, .Regular, 2.0):
            return 65
        // iPhone 6+ portrait
        case (.Compact, .Regular, 3.0):
            return 75
        // iPhone 6+ Landscape
        case (.Regular, .Compact, _):
            return 90
        // iPad Landscape or Portrait
        case (.Regular, .Regular, _):
            return 145
        default:
            fatalError("Unsupported size class")
        }
    }
    
}
