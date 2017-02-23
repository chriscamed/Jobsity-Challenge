//
//  SeriesListTableViewCell.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class SerieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serieName: UILabel!
    @IBOutlet weak var serieCoverImage: UIImageView!
    @IBOutlet weak var serieLanguage: UILabel!
    @IBOutlet weak var serieGenres: UILabel!
	@IBOutlet weak var favoriteButton: UIButton!
	
	var serie: Serie!
	var isFavorite = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	@IBAction func addFavorite(_ button: UIButton) {
		if isFavorite {
			print("Removed from favorites")
            JCSerieMO.removeSerieFromDatabase(withId: serie.id)
            favoriteButton.setImage(UIImage(named: "empty_star.png"), for: .normal)
            isFavorite = false
		} else {
			if JCSerieMO.saveSerieToLocalDatabase(serie) {
				print("Added to favorites")
				isFavorite = true
				favoriteButton.setImage(UIImage(named: "full_star.png"), for: .normal)
			} else {
				print("Error trying to add it as favorite")
			}
			
		}
		
	}

}
