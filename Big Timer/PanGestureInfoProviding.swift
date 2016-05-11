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
    func verticalPan(sender: AnyObject)
}

extension PanGestureInfoReceiving where Self: UIViewController {
    func verticalPan(sender: AnyObject) {
        let gestureRecognizer = sender as! UIPanGestureRecognizer
        let velocity = -gestureRecognizer.velocityInView(view).y
        let translation = -gestureRecognizer.translationInView(view).y
        verticalPanInfo(velocity, translation: translation)
    }
}