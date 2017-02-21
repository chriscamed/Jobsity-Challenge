//
//  EpisodeDetailViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/21/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var episodeCoverImageView: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var seasonNumberLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var episode: Episode?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholderImg = UIImage(named: "placeholder.png")
        if let imgURL = episode?.imageURL {
            episodeCoverImageView.af_setImage(withURL: URL(string: imgURL)!, placeholderImage: placeholderImg)
        }
        
        summaryTextView.text = "No summary"
        if let summaryText = episode?.summary {
            var attrString = NSMutableAttributedString()
            do {
                attrString = try NSMutableAttributedString(data: summaryText.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                                           options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                     NSForegroundColorAttributeName: UIColor.black],
                                                           documentAttributes: nil)
                
                let fullRange : NSRange = NSMakeRange(0, attrString.length)
                attrString.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 17)], range: fullRange)
                summaryTextView.attributedText = attrString
                summaryTextView.contentOffset = CGPoint.zero
            } catch {
                print(error)
            }
        }
        
        summaryTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        episodeNameLabel.text = episode?.name
        episodeNumberLabel.text = "\(episode!.number)"
        seasonNumberLabel.text = episode?.season
        
        
    }

}
