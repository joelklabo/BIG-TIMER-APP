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
    private let fileManager = NSFileManager.defaultManager()
    
    func readPlist() -> NSDictionary {
        
        if fileManager.fileExistsAtPath(fileURL().path!) {
            return NSDictionary(contentsOfURL: fileURL())!
        }
        
        guard let plistPath = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist") else {
            fatalError()
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: plistPath) else {
            fatalError()
        }
        
        return dictionary
    }
    
    func save(dictionary: NSDictionary) {
        if dictionary.writeToURL(fileURL(), atomically: true) {
            print("Saved: \(dictionary)")
        }
    }
    
    private func fileURL() -> NSURL {
        let documentsDirectory = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
        return documentsDirectory.URLByAppendingPathComponent(filePath)
    }

}