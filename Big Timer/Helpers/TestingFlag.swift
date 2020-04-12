//
//  TestingFlag.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/12/20.
//  Copyright © 2020 Joel Klabo. All rights reserved.
//

import UIKit

extension UIApplication {
    var isTesting: Bool {
        return ProcessInfo().arguments.contains("isTesting")
    }
}
