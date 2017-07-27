//
//  InitialViewController.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import UIKit

class InitialViewController: BaseViewController {
    
    @IBOutlet weak var textFieldNickName:UITextField?
    @IBOutlet weak var buttonContinue:UIButton?
	
	let viewModel = InitialViewModel.self
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//Adds tap gesture to hide keypad
		self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(InitialViewController.didViewTapped)))
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.isNavigationBarHidden = true
		
		//If there is user already saved and is not coming from messages view, user will push message view directly.
		if viewModel.shared.checkUserAvailability() && MessagesViewModel.shared.didLeaveButtonTapped == false {
			viewModel.shared.user = UserDefaultsHelper.user
			viewModel.shared.pushToMessagesController(withNavigationController: self.navigationController!)
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.isNavigationBarHidden = false
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//MARK: TapGesture Methods
	
	/// Hides keypad
	func didViewTapped() {
		self.textFieldNickName?.resignFirstResponder()
	}
	
    //MARK: IBActions
    @IBAction func didContinueButtonTapped(_ sender:UIButton) {
		
		//Controls input text
		if viewModel.shared.canPassToMessageView(inputText: (self.textFieldNickName?.text)!) {
			viewModel.shared.user = UserModel(avatarUrl: "person", id: Int(-1), nickname: (self.textFieldNickName?.text)!)
			viewModel.shared.pushToMessagesController(withNavigationController: self.navigationController!)
		}
		else {
			super.showAlert(withTitle: "Error", message: "Nickname should be longer than two characters!")
		}
    }
}
