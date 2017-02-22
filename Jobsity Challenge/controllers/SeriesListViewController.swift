//
//  ViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit
import AlamofireImage
import SmileLock

class SeriesListViewController: UIViewController {
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var serieList: [Serie] = []
    fileprivate let nextPageThresholdInRows: CGFloat = 50.0
    fileprivate var currentPage = 1
    fileprivate var isLoading = false
    fileprivate var isEndOfPages = false
    fileprivate var selectedRow = 0
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let authenticationVC = storyboard?.instantiateViewController(withIdentifier: "authenticationViewController") as! AuthenticationViewController
        authenticationVC.modalPresentationStyle = .overCurrentContext
        present(authenticationVC, animated: true, completion: nil)
        progress.startAnimating()
        progress.hidesWhenStopped = true
        loadSeries(atPage: currentPage)
    }
    
    func showAlertView(withMessage message: String, andTitle error: String) {
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func loadSeries(atPage page: Int) {
        isLoading = true
        SeriesConnection().listSeries(fromServiceURL: Constants.LIST_SHOWS_BY_PAGE + "\(page)") { [unowned self] data in
            self.progress.stopAnimating()
            self.tableView.isHidden = false
            
            if data == nil {
                self.showAlertView(withMessage: "Data is nil", andTitle: "Error")
            } else if (data is Error) {
                self.showAlertView(withMessage: "Error: \n\(data as! Error)", andTitle: "Error")
            } else if data is [Serie] {
                let listOfSeries = data as! [Serie]
                if listOfSeries.count == 0 {
                    self.isEndOfPages = true
                } else {
                    self.serieList += listOfSeries
                    self.tableView.reloadData()
                }
            }
            
            self.isLoading = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SerieDetailViewController {
            vc.serie = serieList[selectedRow]
        }
    }
}


// MARK: SeriesListViewController delegates

extension SeriesListViewController: UITableViewDelegate, UITableViewDataSource, PasswordInputCompleteProtocol {
    
    // MARK: - Table View delegate and datasource methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placeholderImg = UIImage(named: "placeholder_img.jpg")
        let cell = tableView.dequeueReusableCell(withIdentifier: "seriesListingCell", for: indexPath) as! SerieListTableViewCell
        cell.serieName.text = serieList[indexPath.item].name
        cell.serieCoverImage.image = placeholderImg
        cell.serieLanguage.text = "Language: \(serieList[indexPath.row].language)"
        let genres = serieList[indexPath.row].genres
        
        if genres.count > 0 {
            cell.serieGenres.text = "Genres: \(genres.joined(separator: "\n"))"
        }
        
        if let imgURL = serieList[indexPath.row].coverImgURL {
            cell.serieCoverImage.af_setImage(withURL: URL(string: imgURL)!, placeholderImage: placeholderImg)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "showSerieDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serieList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isLoading && !isEndOfPages {
            let threshold = tableView.contentSize.height - (tableView.rowHeight * self.nextPageThresholdInRows)
            if scrollView.contentOffset.y >= threshold {                
                currentPage += 1
                loadSeries(atPage: currentPage)
            }
        }
        
    }
    
    // MARK: - SmileLock methods
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: NSError?) {
        
    }
    
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        print("input completed -> \(input)")
        //handle validation wrong || success
    }
    
}

