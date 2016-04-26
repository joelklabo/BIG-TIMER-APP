//
//  PlistReader.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/25/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct PlistReader {
    
    let fileName: String
    
    func readPlist() -> NSMutableDictionary {
        
        var format = NSPropertyListFormat.XMLFormat_v1_0
        let plist: AnyObject?
        
        guard let plistPath = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist") else {
            fatalError()
        }
        
        guard let plistData = NSFileManager.defaultManager().contentsAtPath(plistPath) else {
            fatalError()
        }
        
        do {
            plist = try NSPropertyListSerialization.propertyListWithData(plistData, options: .MutableContainersAndLeaves, format: &format)
        } catch {
            fatalError()
        }
        
        guard let plistDictionary = plist as? NSMutableDictionary else {
            fatalError()
        }
        
        return plistDictionary
    }
    
}