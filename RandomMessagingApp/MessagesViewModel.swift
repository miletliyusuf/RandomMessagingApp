//
//  MessagesViewModel.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 27/07/2017.
//  Copyright © 2017 Miletli. All rights reserved.
//

import Foundation
import UIKit

final class MessagesViewModel {
	
	private init() { }
	
	// MARK: Shared Instance
	static let shared = MessagesViewModel()
	
	
	/// Controls if the user come back from message view to main view
	var didLeaveButtonTapped:Bool = false

	
	/// Sets navigationview back item title.
	///
	/// - Parameters:
	///   - navigationController: UINavigationController
	///   - string: String value of title
	func setNavigationBackTitle(forNavigationController navigationController:UINavigationController, withString string:String) {
		let backButton = UIBarButtonItem()
		backButton.title = "Leave"
		navigationController.navigationBar.topItem!.backBarButtonItem = backButton
	}
	
	
	/// Controls if user can press send button or not. If input value characters count greater than 0 user can press.
	///
	/// - Parameter string: String value of input text
	/// - Returns: Bool
	func isSendButtonEnabled(message string:String) -> Bool {
		return string.characters.count > 0
	}
}
