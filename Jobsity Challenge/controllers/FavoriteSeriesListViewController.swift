//
//  FavoriteSeriesListViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 22/02/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class FavoriteSeriesListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	fileprivate var seriesList: [Serie] = []
	fileprivate var selectedRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
		loadDataFromDatabase()
    }
	
	func loadDataFromDatabase() {
		guard let series = JCSerieMO.loadSeriesFromLocalDatabase() else {
			return
		}
		
		seriesList = series
		tableView.reloadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? SerieDetailViewController {
			vc.serie = seriesList[selectedRow]
		}
	}

}

// MARK: FavoriteSeriesListViewController delegates

extension FavoriteSeriesListViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: - Table View delegate and data source methods
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let placeholderImg = UIImage(named: "placeholder_img.jpg")
		let cell = tableView.dequeueReusableCell(withIdentifier: "seriesListingCell", for: indexPath) as! SerieListTableViewCell
		cell.favoriteButton.isHidden = true
		cell.serieName.text = seriesList[indexPath.item].name
		cell.serieCoverImage.image = placeholderImg
		cell.serieLanguage.text = "Language: \(seriesList[indexPath.row].language)"
		let genres = seriesList[indexPath.row].genres
		
		if genres.count > 0 {
			cell.serieGenres.text = "Genres: \(genres.joined(separator: "\n"))"
		}
		
		if let imgURL = seriesList[indexPath.row].coverImgURL {
			cell.serieCoverImage.af_setImage(withURL: URL(string: imgURL)!, placeholderImage: placeholderImg)
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedRow = indexPath.row
		performSegue(withIdentifier: "showSerieDetail", sender: nil)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return seriesList.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
}
