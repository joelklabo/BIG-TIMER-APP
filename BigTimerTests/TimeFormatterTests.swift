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
    
    func testThatTimeIsFormattedCorrectly() {
        let tenSeconds = 10
        let tenSecondsFormattedString = formatter.formatTime(tenSeconds)
        XCTAssertTrue(tenSecondsFormattedString == "10")
        
        let oneMinuteInSeconds = 60
        let oneMinuteFormattedString = formatter.formatTime(oneMinuteInSeconds)
        XCTAssertTrue(oneMinuteFormattedString == "1:00")
        
        let oneHourInSeconds = 60 * oneMinuteInSeconds
        let oneHourFormattedString = formatter.formatTime(oneHourInSeconds)
        XCTAssertTrue(oneHourFormattedString == "1:00:00")
        
        let oneHourOneMintuteAndTenSeconds = oneHourInSeconds + oneMinuteInSeconds + tenSeconds
        let oneHourOneMinuteAndTenSecondsFormattedString = formatter.formatTime(oneHourOneMintuteAndTenSeconds)
        XCTAssertTrue(oneHourOneMinuteAndTenSecondsFormattedString == "1:01:10")
    }
}
