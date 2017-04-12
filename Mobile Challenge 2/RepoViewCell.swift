//
//  RepoViewCell.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/9/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit

class RepoViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var starNumber: UILabel!
    @IBOutlet weak var forkNumber: UILabel!
    
    @IBOutlet weak var userImageBackgroud: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
