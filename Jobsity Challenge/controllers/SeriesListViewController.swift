//
//  ViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit
import AlamofireImage

class SeriesListViewController: UIViewController {
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private lazy var serieList: [Serie] = []
    private let nextPageThresholdInRows = 50
    private var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        progress.startAnimating()
        progress.hidesWhenStopped = true
        
        
    }
    
    func showAlertView(withMessage message: String, andTitle error: String) {
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func loadSeries(atPage page: Int) {
        SeriesConnection().listSeries(fromServiceURL: Constants.LIST_SHOWS_BY_PAGE + "\(page)") { [unowned self] data in
            self.progress.stopAnimating()
            self.tableView.isHidden = false
            
            if data == nil {
                self.showAlertView(withMessage: "Data is nil", andTitle: "Error")
            } else if (data is Error) {
                self.showAlertView(withMessage: "Error: \n\(data as! Error)", andTitle: "Error")
            } else if data is [Serie] {
                self.serieList = data as! [Serie]
                self.tableView.reloadData()
            }
        }
    }
}


// MARK: SeriesListViewController delegates

extension SeriesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placeholderImg = UIImage(named: "placeholder_img.jpg")
        let cell = tableView.dequeueReusableCell(withIdentifier: "seriesListingCell", for: indexPath) as! SeriesListTableViewCell
        cell.serieName.text = serieList[indexPath.item].name
        cell.serieCoverImage.image = placeholderImg
        cell.serieCoverImage.af_setImage(withURL: URL(string: serieList[indexPath.row].coverImgURL)!, placeholderImage: placeholderImg)
        cell.serieLanguage.text = "Language: \(serieList[indexPath.row].language)"
        let genres = serieList[indexPath.row].genres
        if genres.count > 0 {
            cell.serieGenres.text = "Genres: \(genres.joined(separator: "\n"))"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serieList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentSize.height)
    }
    
}

