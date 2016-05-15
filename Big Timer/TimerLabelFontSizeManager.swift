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
    
    private static func sizeForSmall(numberOfCharacters: Int) -> CGFloat {
        return 65
    }
    
    private static func sizeForMedium(numberOfCharacters: Int) -> CGFloat {
        return 75
    }
    
    private static func sizeForLarge(numberOfCharacters: Int) -> CGFloat {
        return 90
    }
    
    private static func sizeForExtraLarge(numberOfCharacters: Int) -> CGFloat {
        return 145
    }
}

protocol TimerLabelFontSizeManagerDelegate {
    func updateTimer(label: UILabel, traitCollection: UITraitCollection, time: String)
}

extension TimerLabelFontSizeManagerDelegate {
    func updateTimer(label: UILabel, traitCollection: UITraitCollection, time: String) {
        let fontSize = TimerLabelFontSizeManager.sizeFor(traitCollection, numberOfCharacters: time.characters.count)
        label.text = time
        label.font = UIFont.systemFontOfSize(fontSize)
    }
}
