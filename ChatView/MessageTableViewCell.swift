//
//  MessageTableViewCell.swift
//  ChatView
//
//  Created by Kapil Rathore on 12/02/16.
//  Copyright © 2016 Kapil Rathore. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var msgTitle2: UILabel!
    @IBOutlet weak var msgStatus2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
