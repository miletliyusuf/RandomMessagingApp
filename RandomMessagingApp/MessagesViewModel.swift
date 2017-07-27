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
	
	var didLeaveButtonTapped:Bool = false

	func setNavigationBackTitle(forNavigationController navigationController:UINavigationController, withString string:String) {
		let backButton = UIBarButtonItem()
		backButton.title = "Leave"
		navigationController.navigationBar.topItem!.backBarButtonItem = backButton
	}
	
	func isSendButtonEnabled(message string:String) -> Bool {
		return string.characters.count > 0
	}
}
