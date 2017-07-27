//
//  MessagesViewModelTests.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 28/07/2017.
//  Copyright © 2017 Miletli. All rights reserved.
//

import XCTest
@testable import RandomMessagingApp

class MessagesViewModelTests: XCTestCase {
	
	let viewModel = MessagesViewModel.self
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
	
	func testIsSendButtonEnabled() {
		XCTAssertTrue(viewModel.shared.isSendButtonEnabled(message: "Hello Dear!"))
	}
    
}
