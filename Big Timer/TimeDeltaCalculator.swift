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

    
    static func timeDeltaFrom(velocity: Double, translation: Double) -> Double {
    
        // Velocity range on device
        // 0 > 2000 (iPhone)
        // 0 > 20000 (tvOS)
        
        #if os(iOS)
        let maxVelocity: Double = 2000
        #elseif os(tvOS)
        let maxVelocity: Double = 12000
        #endif
        
        let maxTimeToAdd: Double = 12
        let absoluteVelocity = min(abs(velocity), maxVelocity)
        let velocityScale: Double
        
        // if velocity is towards the upper range do not modify
        // if it is towards the lower range add additional slowing
        if absoluteVelocity > (maxVelocity / 2) {
            // upper range
            velocityScale = absoluteVelocity / maxVelocity
        } else {
            // lower range
            velocityScale = (absoluteVelocity / 5) / maxVelocity
        }
        
        let timeDelta = maxTimeToAdd * velocityScale
        
        // Translation used purely for determining direction
        if (translation > 0) {
            // Add time
            return timeDelta
        } else if (translation < 0) {
            // Remove time
            return -timeDelta
        } else {
            // Do nothing
            return 0
        }
    }
}
