//
//  ReceivedMessageCell.swift
//  RandomMessagingApp
//
//  Created by Yusuf Miletli on 7/27/17.
//  Copyright © 2017 Miletli. All rights reserved.
//

import UIKit

class ReceivedMessageCell: UITableViewCell {
    
    @IBOutlet weak var imageViewAvatar:UIImageView?
    @IBOutlet weak var labelName:UILabel?
    @IBOutlet weak var textViewMessage:UITextView?
    @IBOutlet weak var labelDate:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
