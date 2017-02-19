//
//  ViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class SeriesListViewController: UIViewController {
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    lazy var serieList: [Serie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        progress.startAnimating()
        progress.hidesWhenStopped = true
        
        let seriesConnection = SeriesConnection()
        seriesConnection.listSeries(fromServiceURL: Constants.LIST_SHOWS_BY_PAGE + "1") { [unowned self] series in
            self.progress.stopAnimating()
            self.tableView.isHidden = false
        }
    }


}

// MARK: SeriesListViewController delegates

extension SeriesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seriesListingCell", for: indexPath) as! SeriesListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

