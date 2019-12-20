//
//  UserCell.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.nameLabel.text = "Leanne Graham"
//        self.phoneNumberLabel.text = "319-200-3030"
//        self.emailLabel.text = "dontblameme@ola.co"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
