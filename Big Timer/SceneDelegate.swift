//
//  SceneDelegate.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/13/20.
//  Copyright © 2020 Joel Klabo. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.isIdleTimerDisabled = true
    }
}
