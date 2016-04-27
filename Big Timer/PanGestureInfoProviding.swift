//
//  PanGestureInfoProviding.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/26/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

protocol PanGestureInfoReceiving {
    func verticalPanInfo(velocity: CGFloat, translation: CGFloat)
}