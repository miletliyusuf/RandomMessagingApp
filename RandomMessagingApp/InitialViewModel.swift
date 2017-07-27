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
	
	/// Created User object with nickname
	var user:UserModel! {
		didSet {
			UserDefaultsHelper.user = user
		}
	}
	
	//MARK: Methods
	
	/// Controls the character count of input text if it is greater than 2 returns *true* else *false*
	///
	/// - Parameter string: Input String
	/// - Returns: Bool
	func canPassToMessageView(inputText string:String) -> Bool {
		return string.characters.count > 2
	}
	
	
	/// Push method
	///
	/// - Parameter navigationController: UINavigationController
	func pushToMessagesController(withNavigationController navigationController:UINavigationController) {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let messagesController = storyBoard.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
		messagesController.user = user
		navigationController.pushViewController(messagesController, animated: true)
	}
	
	
	/// Checks there are saved user or not.
	///
	/// - Returns: Bool
	func checkUserAvailability() -> Bool {
		return (UserDefaultsHelper.user != nil) ? true : false
	}
}
