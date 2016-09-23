//
//  PlistReader.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/25/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct PlistReader {
    
    fileprivate let fileName = "CustomTimers"
    fileprivate let filePath = "CustomTimers.plist"
    fileprivate let fileManager = FileManager.default
    
    func readPlist() -> NSDictionary {
        
        if fileManager.fileExists(atPath: fileURL().path) {
            return NSDictionary(contentsOf: fileURL())!
        }
        
        guard let plistPath = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            fatalError()
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: plistPath) else {
            fatalError()
        }
        
        return dictionary
    }
    
    func save(_ dictionary: NSDictionary) {
        if dictionary.write(to: fileURL(), atomically: true) {
        }
    }
    
    fileprivate func fileURL() -> URL {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last!
        return documentsDirectory.appendingPathComponent(filePath)
    }

}
