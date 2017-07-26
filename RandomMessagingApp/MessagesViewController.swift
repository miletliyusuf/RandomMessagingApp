//
//  MessagesViewController.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import UIKit

class MessagesViewController: BaseViewController {
    
    @IBOutlet weak var tableViewMessages:UITableView!
    @IBOutlet weak var textFieldMessage:UITextField!
    @IBOutlet weak var buttonSend:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Custom Methods
    func initTableView() {
        self.tableViewMessages.delegate = self
        self.tableViewMessages.dataSource = self
    }
	
	//MARK: Requests
	
	func fetchFirstMessages() {
		let r = MessagesRequest()
		_ = MessagesDataService.messages(requestModel: r).subscribe(onNext: { (response) in
			
			if let messagesResponse:MessagesResponse = response as! MessagesResponse? {
				
			}
			
		}, onError: nil, onCompleted: nil, onDisposed: nil)
		
	}
    
}

extension MessagesViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
