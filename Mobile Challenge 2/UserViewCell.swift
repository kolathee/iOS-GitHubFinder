//
//  UserViewCell.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/6/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var backGroundAvatar: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
