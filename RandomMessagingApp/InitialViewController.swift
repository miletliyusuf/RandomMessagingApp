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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    //MARK: IBActions
    @IBAction func didContinueButtonTapped(_ sender:UIButton) {
        let user:UserModel = UserModel(avatarUrl: "", id: -1, nickname: (self.textFieldNickName?.text)!)
        let messagesController = self.storyboard?.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
        messagesController.user = user
        self.navigationController?.pushViewController(messagesController, animated: true)
    }
}
