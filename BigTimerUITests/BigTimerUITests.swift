//
//  BigTimerUITests.swift
//  BigTimerUITests
//
//  Created by Joel Klabo on 9/25/16.
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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        snapshot("timer-view-one")
        let element = app.otherElements.containing(.staticText, identifier:"0").children(matching: .other).element(boundBy: 2)
        element.tap()
        
        let elementsQuery = app.tables.otherElements.containing(.button, identifier:"👍")
        elementsQuery.children(matching: .button).element(boundBy: 1).tap()
        
        let doneButton = app.navigationBars["Settings"].buttons["Done"]
        doneButton.tap()
        snapshot("timer-view-two")

        element.tap()
        elementsQuery.children(matching: .button).element(boundBy: 2).tap()
        doneButton.tap()
        snapshot("timer-view-three")
    }
    
    
}
