//
//  PeopleListTableViewCell.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/22/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class PeopleListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var peopleImageView: UIImageView!
    @IBOutlet weak var peopleNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
