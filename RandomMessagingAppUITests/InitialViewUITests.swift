//
//  InitialViewUITests.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 28/07/2017.
//  Copyright © 2017 Miletli. All rights reserved.
//

import XCTest

class InitialViewUITests: XCTestCase {
	
	let app = XCUIApplication()
	
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
		
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testUIElementsExisting() {
		XCTAssert(app.textFields["textFieldNickname"].exists)
		XCTAssert(app.buttons["buttonContinue"].exists)
	}
	
	func testToGoToMessageView() {
		let textField = app.textFields["textFieldNickname"]
		let continueButton = app.buttons["buttonContinue"]
		textField.tap()
		textField.typeText("Yu")
		continueButton.tap()
		XCTAssert(app.alerts["Error"].exists)
		textField.tap()
		textField.typeText("suf Miletli")
		continueButton.tap()
		XCTAssert(app.navigationBars["Yusuf Miletli"].exists)
	}
    
}
