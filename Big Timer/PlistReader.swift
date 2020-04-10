//
//  PlistReader.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/25/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct PlistReader {
    
    private let fileName = "CustomTimers"
    private let filePath = "CustomTimers.plist"
    private let fileManager = FileManager.default
    
    func readPlist() -> NSDictionary {
        
        if fileManager.fileExists(atPath: fileURL.path) {
            return NSDictionary(contentsOf: fileURL)!
        }
        
        guard let plistPath = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            fatalError()
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: plistPath) else {
            fatalError()
        }
        
        return dictionary
    }
    
    func save(dictionary: NSDictionary) {
        if dictionary.write(to: fileURL, atomically: true) {
        }
    }
    
    private var fileURL: URL {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last!
        return documentsDirectory.appendingPathComponent(filePath)
    }

}
