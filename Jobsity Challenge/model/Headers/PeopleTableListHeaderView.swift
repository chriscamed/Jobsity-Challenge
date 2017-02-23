//
//  PeopleTableListHeader.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 23/02/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation
import UIKit

class PeopleTableListHeaderView: UIView {
	
	@IBOutlet weak var peopleImageView: UIImageView!
	@IBOutlet weak var peopleNameLabel: UILabel!
	
	class func instanceFromNib() -> UIView {
		return UINib(nibName: "PeopleTableListHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
	}
	
}
