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
    
    static let maxCharacters = 7
    static let sizeMultiplier = 5
    
    static func sizeFor(traits: UITraitCollection, numberOfCharacters: Int) -> CGFloat {
        let width = traits.horizontalSizeClass
        let height = traits.verticalSizeClass
        let scale = traits.displayScale
        switch (width, height, scale) {
        // iPhone Landscape, iPhone, iPhone 6 Portrait
        case (.Compact, .Compact, 2.0), (.Compact, .Regular, 2.0):
            return self.sizeForSmall(numberOfCharacters)
        // iPhone 6+ portrait
        case (.Compact, .Regular, 3.0):
            return self.sizeForMedium(numberOfCharacters)
        // iPhone 6+ Landscape
        case (.Regular, .Compact, _):
            return self.sizeForLarge(numberOfCharacters)
        // iPad Landscape or Portrait
        case (.Regular, .Regular, _):
            return self.sizeForExtraLarge(numberOfCharacters)
        default:
            fatalError("Unsupported size class")
        }
    }
    
    // Optimizing for between 1 and 7 characters
    
    private static func sizeForSmall(numberOfCharacters: Int) -> CGFloat {
        let minimunSize: CGFloat = 75
        let maximumSize: CGFloat = 120
        if numberOfCharacters >= maxCharacters {
            return minimunSize
        }
        return maximumSize - CGFloat(sizeMultiplier * (numberOfCharacters - 1))
    }
    
    private static func sizeForMedium(numberOfCharacters: Int) -> CGFloat {
        let minimunSize: CGFloat = 85
        let maximumSize: CGFloat = 145
        if numberOfCharacters >= maxCharacters {
            return minimunSize
        }
        return maximumSize - CGFloat(sizeMultiplier * (numberOfCharacters - 1))
    }
    
    private static func sizeForLarge(numberOfCharacters: Int) -> CGFloat {
        let minimunSize: CGFloat = 100
        let maximumSize: CGFloat = 165
        if numberOfCharacters >= maxCharacters {
            return minimunSize
        }
        return maximumSize - CGFloat(sizeMultiplier * (numberOfCharacters - 1))
    }
    
    private static func sizeForExtraLarge(numberOfCharacters: Int) -> CGFloat {
        let minimunSize: CGFloat = 155
        let maximumSize: CGFloat = 200
        if numberOfCharacters >= maxCharacters {
            return minimunSize
        }
        return maximumSize - CGFloat(sizeMultiplier * (numberOfCharacters - 1))
    }
}

protocol TimerLabelFontSizeManagerDelegate {
    func updateTimer(label: UILabel, traitCollection: UITraitCollection, time: String)
}

extension TimerLabelFontSizeManagerDelegate {
    func updateTimer(label: UILabel, traitCollection: UITraitCollection, time: String) {
        let fontSize = TimerLabelFontSizeManager.sizeFor(traitCollection, numberOfCharacters: time.characters.count)
        label.text = time
        label.font = UIFont.monospacedDigitSystemFontOfSize(fontSize, weight: UIFontWeightMedium)
    }
}
