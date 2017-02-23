//
//  SerieDetailTabViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/20/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class SerieDetailTabViewController: UIViewController {
    
    @IBOutlet weak var serieNameLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!    
    @IBOutlet weak var serieDetailHeightConstraint: NSLayoutConstraint!
	
	fileprivate let iPhone5Height: CGFloat = 568.0

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenHeight = UIScreen.main.bounds.height
        print(screenHeight)
        
        if screenHeight <= iPhone5Height {
            serieDetailHeightConstraint.constant = 100
        }
        
        summaryTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    class func instantiateFromStoryboard() -> SerieDetailTabViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SerieDetailTabViewController
    }

}
