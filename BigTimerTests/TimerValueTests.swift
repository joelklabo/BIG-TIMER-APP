//
//  TimerValueTests.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/4/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import XCTest

class TimerValueTests: XCTestCase {
    
    var timerValue = TimerValue()
    
    override func setUp() {
        super.setUp()
        timerValue = TimerValue()
    }
    
    func testThatTimerValueStartsAtZero() {
        XCTAssertTrue(timerValue.time == 0)
    }
    
    func testThatTimerValueCantGoBelowZero() {
        timerValue.update(-100)
        XCTAssertTrue(timerValue.time == 0)
    }
    
    func testThatYouCanAddTimeToTimerValue() {
        timerValue.update(100)
        XCTAssertTrue(timerValue.time == 100)
    }
    
    func testThatYouCanSubtractTime() {
        timerValue.update(100)
        timerValue.update(-50)
        XCTAssertTrue(timerValue.time == 50)
    }
}
