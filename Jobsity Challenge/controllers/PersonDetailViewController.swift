//
//  PersonDetailViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 23/02/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var progress: UIActivityIndicatorView!
	fileprivate var series: [Serie] = []
	var person: Person!

    override func viewDidLoad() {
        super.viewDidLoad()
		progress.startAnimating()
		progress.hidesWhenStopped = true
		
		let headerView = PeopleTableListHeaderView.instanceFromNib() as! PeopleTableListHeaderView
		
		let placeholderImg = UIImage(named: "placeholder_img.jpg")
		headerView.peopleNameLabel.text = person.name
		headerView.peopleImageView.image = placeholderImg
		if let imgURL = person.imageURL {
			headerView.peopleImageView.af_setImage(withURL: URL(string: imgURL)!, placeholderImage: placeholderImg)
		}
		
		tableView.tableHeaderView = headerView
		
		loadSeries()
    }
	
	private func loadSeries() {
        SeriesConnection().listSeries(byPersonId: person.id) { [unowned self] data in
			if data == nil {
				self.showAlertView(withMessage: "Data is nil", andTitle: "Error")
			} else if (data is Error) {
				self.showAlertView(withMessage: "Error: \n\(data as! Error)", andTitle: "Error")
			} else if data is [Serie] {
				self.series = data as! [Serie]
				if self.series.count > 0 { self.tableView.reloadData() }
				self.tableView.isHidden = false
				self.progress.stopAnimating()				
			}
		}
	}
	
	func showAlertView(withMessage message: String, andTitle error: String) {
		let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertController, animated: true, completion: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? SerieDetailViewController {
			vc.serie = sender as? Serie
		}
	}

}

// MARK: PersonDetailViewController delegates

extension PersonDetailViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: - Table view data source
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return series.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "peopleListTableViewCell", for: indexPath) 
		cell.textLabel?.text = series[indexPath.row].name
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Person series"
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showSerieDetail", sender: series[indexPath.row])
	}
}
