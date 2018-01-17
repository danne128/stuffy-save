//
//  WorkoutsTableViewCell.swift
//  Trainingapp
//
//  Created by Daniel Trondsen Wallin on 2017-12-19.
//  Copyright © 2017 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit

class WorkoutsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workOutNameLabel: UILabel!
    @IBOutlet weak var workOutCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
