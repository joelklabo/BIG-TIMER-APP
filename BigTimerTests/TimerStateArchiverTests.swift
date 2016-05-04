//
//  TimerStateArchiverTests.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/4/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import XCTest

class TimerStateArchiverTests: XCTestCase {

    func testThatTimerStateCanBeSavedAndRetrieved() {
        let timerState = TimerState.zeroState()
        TimerStateArchiver.archiveTimerState(timerState)
        let retrievedState = TimerStateArchiver.retrieveTimerState()
        XCTAssert(timerState == retrievedState)
    }
    
    func testThatRetrievedTimerCanBeUpdated() {
        let timerState = runningZeroTimerState()
        TimerStateArchiver.archiveTimerState(timerState)
        let retrievedTimerState = TimerStateArchiver.retrieveTimerState()
        if let updatedTimerState = TimerStateArchiver.updateTimerState(retrievedTimerState!, forDate: NSDate(timeIntervalSince1970: 1)) {
            XCTAssert(updatedTimerState.timerValue == 1)
        } else {
            XCTFail()
        }
    }
    
    func testThatNilIsReturnedWhenTimerHasPassedZero() {
        let timerState = runningZeroTimerState()
        timerState.timerValue = 1
        timerState.direction = .Down
        TimerStateArchiver.archiveTimerState(timerState)
        let retrievedTimerState = TimerStateArchiver.retrieveTimerState()
        if let _ = TimerStateArchiver.updateTimerState(retrievedTimerState!, forDate: NSDate(timeIntervalSince1970: 10)) {
            XCTFail()
        }
    }
    
    func testThatTimerStateIsntUpdatedWhenNotRunning() {
        let timerState = TimerState.zeroState()
        TimerStateArchiver.archiveTimerState(timerState)
        let retrievedTimerState = TimerStateArchiver.retrieveTimerState()
        if let _ = TimerStateArchiver.updateTimerState(retrievedTimerState!, forDate: NSDate(timeIntervalSince1970: 1)) {
            XCTFail("Should not have updated time")
        }
    }
    
    private func runningZeroTimerState() -> TimerState {
        let timerState = TimerState()
        timerState.direction = .Up
        timerState.timerValue = 0
        timerState.timeStamp = NSDate(timeIntervalSince1970: 0)
        timerState.isRunning = true
        return timerState
    }
    
}
