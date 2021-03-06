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
    @IBOutlet weak var textViewMessageInput:UITextView?
    @IBOutlet weak var buttonSend:UIButton?
    @IBOutlet var constKeypadBottom: NSLayoutConstraint?
    
    var receivedCell:MessageCell?
    var senderCell:MessageCell?
    
    var arrayMessages:[MessageModel]? {
        didSet{
            if (self.arrayMessages?.count)! > 0 {
                self.tableView?.reloadData()
				self.scrollToBottom(isAnimated: true)
            }
        }
    }
    
    var user:UserModel?
	
	let viewModel = MessagesViewModel.self
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//Sets navigation back title
		viewModel.shared.setNavigationBackTitle(forNavigationController: self.navigationController!,
		                                        withString: "Leave")
		//Sets navigation title
		title = (user?.nickname)!
		
		self.textViewMessageInput?.delegate = self
		
		initTableView()
        fetchFirstMessages()
        addObserverToKeypad()
    }
	
	override func willMove(toParentViewController parent: UIViewController?) {
		super.willMove(toParentViewController: parent)
		viewModel.shared.didLeaveButtonTapped = true
	}

	///Deinitialize observer of keypad
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Custom Methods
	
	
    /// Sets tableview requirements
    func initTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerXib(name: self.receivedCellIdentifier)
        self.tableView?.registerXib(name: self.senderCellIdentifier)
        self.tableView?.estimatedRowHeight = 250
        self.tableView?.rowHeight = UITableViewAutomaticDimension
		self.tableView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MessagesViewController.didTableViewTapped)))
    }
	
	
	/// Sends message
	func sendMessage() {
		let message = MessageModel(id: -1, text: (self.textViewMessageInput?.text)!, timestamp: NSDate().timeIntervalSince1970, user: user!)
		self.arrayMessages!.append(message)
		self.textViewMessageInput?.text = ""
	}
	
	/// Hides keypad
	func didTableViewTapped() {
		self.textViewMessageInput?.resignFirstResponder()
	}
	
	
	/// Scrolls tableview to bottom message
	///
	/// - Parameter status: Bool value of animated situation
	func scrollToBottom(isAnimated status:Bool) {
		if self.arrayMessages != nil {
			self.tableView?.scrollToRow(at: IndexPath.init(row: (self.arrayMessages?.count)! - 1, section: 0), at: .bottom, animated: status)
		}
	}
	
	
    /// Handles keypad open situation
    func addObserverToKeypad() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
    }
	
	/// Sticks input view top of keypad
    func keyboardNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as?     NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions().rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.constKeypadBottom?.constant = 0.0
            } else {
                self.constKeypadBottom?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
							self.view.layoutIfNeeded()
							self.scrollToBottom(isAnimated: true)
            },
                           completion: nil)
        }
    }

	
	//MARK: Requests
	
	/// Messages request
	func fetchFirstMessages() {
		let r = MessagesRequest()
		_ = MessagesDataService.messages(requestModel: r).subscribe(onNext: { (response) in
			 
			if let res:MessagesResponse = response as! MessagesResponse? {
                self.arrayMessages = res.messages!
			}
			
		}, onError: { (error) in
			super.showAlert(withTitle: "Error", message: error.localizedDescription)
		}, onCompleted: nil, onDisposed: nil)
		
	}
    
    //MARK: IBActions
    @IBAction func didSendButtonTapped(_ sender:UIButton) {
		sendMessage()
		self.buttonSend?.isEnabled = false
		self.buttonSend?.alpha = 0.5
    }
    
}

//MARK: UITextViewDelegate
extension MessagesViewController:UITextViewDelegate {
	
	func textViewDidChange(_ textView: UITextView) {
		let isSendButtonEnabled = viewModel.shared.isSendButtonEnabled(message: (textViewMessageInput?.text)!)
		self.buttonSend?.isEnabled = isSendButtonEnabled
		self.buttonSend?.alpha = isSendButtonEnabled ? 1 : 0.5
		textView.sizeThatFits(textView.contentSize)
		scrollToBottom(isAnimated: false)
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if text == "\n" {
			sendMessage()
			return false
		}
		else {
			return true
		}
	}
	
}

//MARK: UITableViewDelegate,UITableViewDataSource
extension MessagesViewController:UITableViewDelegate,UITableViewDataSource {
	
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
			self.senderCell?.textViewMessage?.sizeToFit()
            self.senderCell?.labelDate?.text = instantMessage.timestamp?.timestampToDateString()
            self.senderCell?.labelName?.text = instantMessage.user?.nickname
            self.senderCell?.imageViewAvatar?.image = UIImage(named: (instantMessage.user?.avatarUrl)!)
            return self.senderCell!
        }
        else {
            self.receivedCell = tableView.dequeueReusableCell(withIdentifier: self.receivedCellIdentifier, for: indexPath) as? MessageCell
            self.receivedCell?.textViewMessage?.text = instantMessage.text!
			self.receivedCell?.textViewMessage?.sizeToFit()
            self.receivedCell?.labelDate?.text = instantMessage.timestamp?.timestampToDateString()
            self.receivedCell?.labelName?.text = instantMessage.user?.nickname
            self.receivedCell?.imageViewAvatar?.kf.setImage(with: URL(string: (instantMessage.user?.avatarUrl)!))
            return self.receivedCell!
        }
    }
}

