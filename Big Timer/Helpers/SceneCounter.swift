//
//  SceneCounter.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/14/20.
//  Copyright © 2020 Joel Klabo. All rights reserved.
//

import UIKit

extension UIApplication {
    var sceneCount: Int {
        return connectedScenes.count
    }
}
