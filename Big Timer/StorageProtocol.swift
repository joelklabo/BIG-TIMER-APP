//
//  StorageProtocol.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/24/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

protocol Storage {
    func setValue(value: AnyObject, key: String)
    func getValueForKey(key: String)
}

extension NSUserDefaults: Storage {
    func setValue(value: AnyObject, key: String) {
        self.setValue(value, forKey: key)
    }
    func getValueForKey(key: String) {
        return self.getValueForKey(key)
    }
}