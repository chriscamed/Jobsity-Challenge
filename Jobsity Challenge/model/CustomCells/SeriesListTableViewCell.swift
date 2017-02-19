//
//  SeriesListTableViewCell.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class SeriesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serieName: UILabel!
    @IBOutlet weak var serieCoverImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
