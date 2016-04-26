//
//  CustomTimerManager.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/25/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct CustomTimerManager {
    
    private let timersKey = "CustomTimers"
    private let plistDictionary = PlistReader(fileName: "CustomTimers").readPlist()
    
    func getTimes() -> Array<String> {
        return parseTimes()
    }
    
    private func parseTimes() -> Array<String> {
        guard let arrayOfTimes = plistDictionary[timersKey] as? Array<AnyObject> else {
            fatalError()
        }
        
        let times = arrayOfTimes.map {
            return String($0)
        }
        
        return times
    }
}