//
//  InitialViewController.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import UIKit

class InitialViewController: BaseViewController {
    
    @IBOutlet weak var textFieldNickName:UITextField!
    @IBOutlet weak var buttonContinue:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let r = MessagesRequest()
        _ = MessagesDataService.messages(requestModel: r).subscribe(onNext: { (response) in
			
			if let messagesResponse:MessagesResponse = response as! MessagesResponse? {
				print(messagesResponse.messages)
			}
			
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
