//
//  RewardsUITests.swift
//  RewardsUITests
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import XCTest

final class RewardsUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = true
        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testExample() {

        let app = XCUIApplication()
        
        let elementsQuery = app.scrollViews.otherElements

        let headerLabel = elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["OTPLogin.header.label"]/*[[".staticTexts[\"Please enter your OTP\"]",".staticTexts[\"OTPLogin.header.label\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        // Header label exists
        XCTAssertEqual(headerLabel.label, "Please enter your OTP")
        XCTAssertEqual(headerLabel.accessibilityTraits.rawValue, 0) // To test `.header`
        
        // OTP Code inout field exists
        let codeInputField = elementsQuery/*@START_MENU_TOKEN@*/.secureTextFields["OTPLogin.code.input"]/*[[".secureTextFields[\"Enter OTP\"]",".secureTextFields[\"OTPLogin.code.input\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertEqual(codeInputField.value as! String, "Enter OTP")
        
        // Submit button exists
        let submitButton = elementsQuery/*@START_MENU_TOKEN@*/.buttons["OTPLogin.submit.button"]/*[[".buttons[\"Submit OTP\"]",".buttons[\"OTPLogin.submit.button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertEqual(submitButton.label, "Submit OTP")
        
        // ----------------------------------------------
        // Typing scenarios : -->
        // -----------------------------------------------
        
        codeInputField.tap()
        
        codeInputField.typeText("aa")
        // Value wont be accepted as character entry
        XCTAssertEqual(codeInputField.value as! String, "Enter OTP")
        // Button remains inactive
        XCTAssertEqual(submitButton.isEnabled, false)
        
        codeInputField.typeText("1")
        XCTAssertEqual(codeInputField.value as! String, "•")
        // Hint gets updated as start typing
        // Button remains inactive
        XCTAssertEqual(submitButton.isEnabled, false)
        
        codeInputField.typeText("2")
        XCTAssertEqual(codeInputField.value as! String, "••")
        // Button remains inactive
        XCTAssertEqual(submitButton.isEnabled, false)
        
        codeInputField.typeText("34")
        XCTAssertEqual(codeInputField.value as! String, "••••")
        // Button becomes Active
        XCTAssertEqual(submitButton.isEnabled, true)
        
        // Clearing text
        codeInputField.clearAndEnterText("")
        // Placeholder comes back
        XCTAssertEqual(codeInputField.value as! String, "Enter OTP")
        // Button becomes Inactive again
        XCTAssertEqual(submitButton.isEnabled, false)
        
        
        // ----------------------------------------------
        // Login Submission scenarios : -->
        // -----------------------------------------------
        
        // Typing incorrect code and submit button
        codeInputField.clearAndEnterText("8282")
        submitButton.tap()
        sleep(3)
        
        // Progress HUD shows
        // TODO: find way to test this
        // XCTAssert(app.staticTexts["Logging you in ..."].exists)
        
        // After 3 sec, login was unsuccessful, still on OTP login screen
        XCTAssert(app.staticTexts["Please enter your OTP"].exists)

        
        // Tap field again, enter correct code and submit button
        codeInputField.tap()
        codeInputField.clearAndEnterText("1234")
        submitButton.tap()
        sleep(3)
        
        // Progress HUD shows
        // TODO: find way to test this
        // XCTAssert(app.staticTexts["Logging you in ..."].exists)

        // After 3 sec, login was successful, check navigation bar of new view

        XCTAssert(app.navigationBars["Reward"].staticTexts["Reward"].exists)
        
        // Back button exists
        let backButton = app.navigationBars["Reward"].buttons.element(boundBy: 0)
        XCTAssert(backButton.exists)
        
        backButton.tap()
        
        // Navigated back to OTP login screen
        XCTAssert(app.staticTexts["Please enter your OTP"].exists)
    
    }
}

private extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(_ text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}
