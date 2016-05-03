//
//  BigTimerUITests.swift
//  BigTimerUITests
//
//  Created by Joel Klabo on 5/2/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import XCTest

class BigTimerUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        setupSnapshot(app)
        app.launch()
    }

    func testScreenshot() {
        snapshot("timerView")
    }
    
}
