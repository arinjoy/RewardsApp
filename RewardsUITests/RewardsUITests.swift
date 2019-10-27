//
//  RewardsUITests.swift
//  RewardsUITests
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import XCTest

class RewardsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let enterOtpSecureTextField = elementsQuery.secureTextFields["Enter OTP"]
        enterOtpSecureTextField.tap()
        
        let loginIconButton = elementsQuery.buttons["login icon"]
        loginIconButton.tap()
        enterOtpSecureTextField.tap()
        loginIconButton.tap()
        app.navigationBars["Reward"].buttons["Back"].tap()
        enterOtpSecureTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }

}
