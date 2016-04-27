//
//  TimeDeltaCalculator.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/26/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

struct TimeDeltaCalculator {
    
    static func timeDeltaFrom(velocity: CGFloat, translation: CGFloat) -> CFTimeInterval {
        var velocityMultiplier = abs(velocity / 600)
        var modifiedTranslation = translation
        if (translation > 0) {
            // Positive translation
            if (translation < 1) {
                // It's between zero and one, bump it up to one
                modifiedTranslation = 1
                velocityMultiplier = velocityMultiplier * 100
            }
        } else {
            // Negative translation
            if (translation > -1) {
                // It's between negative one and zero, move it to negative one
                modifiedTranslation = -1
            }
        }
        // If both values are less than zero fake a 1 so we can get off the ground
        let product = modifiedTranslation * velocityMultiplier
        
        return CFTimeInterval(product)
    }
}