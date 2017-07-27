//
//  InitialViewModelTests.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 28/07/2017.
//  Copyright © 2017 Miletli. All rights reserved.
//

import XCTest
@testable import RandomMessagingApp

class InitialViewModelTests: XCTestCase {
	
	let viewModel = InitialViewModel.self
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testCanPassToMessageView() {
		XCTAssertTrue(viewModel.shared.canPassToMessageView(inputText: "Yusuf Miletli"))
	}
	
	func testCheckUserAvailability() {
		if UserDefaultsHelper.user != nil {
			XCTAssertTrue(viewModel.shared.checkUserAvailability())
		}
		else {
			XCTAssertFalse(viewModel.shared.checkUserAvailability())
		}
	}
}
