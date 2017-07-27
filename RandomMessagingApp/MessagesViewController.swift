//
//  MessagesViewController.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/26/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class MessagesViewController: BaseViewController {
    
    fileprivate let receivedCellIdentifier = "ReceivedMessageCell"
    fileprivate let senderCellIdentifier = "SenderMessageCell"
    
    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var textFieldMessage:UITextField?
    @IBOutlet weak var buttonSend:UIButton?
    
    var receivedCell:MessageCell?
    var senderCell:MessageCell?
    
    var arrayMessages:[MessageModel]? {
        didSet{
            if (self.arrayMessages?.count)! > 0 {
                self.tableView?.reloadData()
                self.tableView?.scrollToRow(at: IndexPath.init(row: (self.arrayMessages?.count)! - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    var user:UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        fetchFirstMessages()
        
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
			 
			if let res:MessagesResponse = response as! MessagesResponse? {
                self.arrayMessages = res.messages!
			}
			
		}, onError: nil, onCompleted: nil, onDisposed: nil)
		
	}
    
    //MARK: IBActions
    @IBAction func didSendButtonTapped(_ sender:UIButton) {
        let message = MessageModel(id: -1, text: (self.textFieldMessage?.text)!, timestamp: NSDate().timeIntervalSince1970, user: user!)
        self.arrayMessages!.append(message)
    }
    
}

//MARK: UITableViewDelegate,UITableViewDataSource
extension MessagesViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMessages == nil ? 0 : self.arrayMessages!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let instantMessage:MessageModel = self.arrayMessages![indexPath.row]
        if instantMessage.user?.id == user?.id {
            self.senderCell = tableView.dequeueReusableCell(withIdentifier: self.senderCellIdentifier, for: indexPath) as? MessageCell
            self.senderCell?.textViewMessage?.text = instantMessage.text!
            self.senderCell?.labelDate?.text = instantMessage.timestamp?.timestampToDateString()
            self.senderCell?.labelName?.text = instantMessage.user?.nickname
            self.senderCell?.imageViewAvatar?.image = UIImage(named: "person")
            return self.senderCell!
        }
        else {
            self.receivedCell = tableView.dequeueReusableCell(withIdentifier: self.receivedCellIdentifier, for: indexPath) as? MessageCell
            self.receivedCell?.textViewMessage?.text = instantMessage.text!
            self.receivedCell?.labelDate?.text = instantMessage.timestamp?.timestampToDateString()
            self.receivedCell?.labelName?.text = instantMessage.user?.nickname
            self.receivedCell?.imageViewAvatar?.kf.setImage(with: URL(string: (instantMessage.user?.avatarUrl)!))
            return self.receivedCell!
        }
    }
}

