//
//  MessagesViewController.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import UIKit

class MessagesViewController: BaseViewController {
    
    fileprivate let receivedCellIdentifier = "ReceivedMessageCell"
    fileprivate let senderCellIdentifier = "SenderMessageCell"
    
    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var textFieldMessage:UITextField?
    @IBOutlet weak var buttonSend:UIButton?
    
    var receivedCell:ReceivedMessageCell?
    var senderCell:SenderMessageCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Custom Methods
    func initTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerXib(name: self.receivedCellIdentifier)
        self.tableView?.registerXib(name: self.senderCellIdentifier)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            self.receivedCell = tableView.dequeueReusableCell(withIdentifier: self.receivedCellIdentifier, for: indexPath) as? ReceivedMessageCell
            return self.receivedCell!
        default:
            self.senderCell = tableView.dequeueReusableCell(withIdentifier: self.senderCellIdentifier, for: indexPath) as? SenderMessageCell
            return self.senderCell!
        }
    }
}
