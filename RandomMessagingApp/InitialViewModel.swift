//
//  InitialViewModel.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 27/07/2017.
//  Copyright © 2017 Miletli. All rights reserved.
//

import Foundation
import UIKit

final class InitialViewModel {
	
	private init() { }
	
	// MARK: Shared Instance
	static let shared = InitialViewModel()
	
	var user:UserModel! {
		didSet {
			UserDefaultsHelper.user = user
		}
	}
	
	func canPassToMessageView(inputText string:String) -> Bool {
		return string.characters.count > 2
	}
	
	func pushToMessagesController(withNavigationController navigationController:UINavigationController) {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let messagesController = storyBoard.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
		messagesController.user = user
		navigationController.pushViewController(messagesController, animated: true)
	}
	
	func checkUserAvailability() -> Bool {
		return (UserDefaultsHelper.user != nil) ? true : false
	}
}
