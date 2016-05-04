//
//  TimeFormatterTests.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/4/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import XCTest

class TimeFormatterTests: XCTestCase {
    
    let formatter = TimeFormatter()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatTimeIsFormattedCorrectly() {
        let oneMinuteInSeconds = 60
        let oneMinuteFormattedString = formatter.formatTime(oneMinuteInSeconds)
        XCTAssertTrue(oneMinuteFormattedString == "1:00")
    }
}
