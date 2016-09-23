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
    func verticalPanInfo(_ velocity: CGFloat, translation: CGFloat)
    func verticalPan(_ sender: AnyObject)
}

extension PanGestureInfoReceiving where Self: UIViewController {
    func verticalPan(_ sender: AnyObject) {
        let gestureRecognizer = sender as! UIPanGestureRecognizer
        let velocity = -gestureRecognizer.velocity(in: view).y
        let translation = -gestureRecognizer.translation(in: view).y
        verticalPanInfo(velocity, translation: translation)
    }
}
