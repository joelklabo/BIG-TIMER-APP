//
//  BigTimerUITests.swift
//  BigTimerUITests
//
//  Created by Joel Klabo on 5/1/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import XCTest

class BigTimerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testScreenshotUsage() {
        XCUIDevice.sharedDevice().orientation = .FaceUp
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        app.staticTexts["0"].tap()
        sleep(14)
        snapshot("01LoginScreen")
    }
    
}
