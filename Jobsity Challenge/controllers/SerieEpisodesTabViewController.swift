//
//  SerieEpisodesTabViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/20/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class SerieEpisodesTabViewController: UIViewController {
    
    var serie: Serie?
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    fileprivate var episodeList: [String:[Episode]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        progress.hidesWhenStopped = true
    }
    
    class func instantiateFromStoryboard() -> SerieEpisodesTabViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SerieEpisodesTabViewController
    }
    
    func loadData() {
        EpisodesConnection().listEpisodes(fromServiceURL: Constants.LIST_EPISODES + serie!.id + "/episodes") { [unowned self] data in
            self.progress.stopAnimating()
            self.tableView.isHidden = false
            
            if data == nil {
                self.showAlertView(withMessage: "Data is nil", andTitle: "Error")
            } else if (data is Error) {
                self.showAlertView(withMessage: "Error: \n\(data as! Error)", andTitle: "Error")
            } else if data is [String:[Episode]] {
                self.episodeList = data as! [String:[Episode]]
                self.tableView.reloadData()
            }
        }
    }
    
    func showAlertView(withMessage message: String, andTitle error: String) {
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

extension SerieEpisodesTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodesListingCell", for: indexPath) as! EpisodeListTableViewCell
        cell.episodeNameLabel.text = episodeList["\(indexPath.section)"]![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeList["\(section)"]!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(episodeList["\(section)"]![0].season)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodeList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "episodeDetailViewController") as! EpisodeDetailViewController
        vc.episode = episodeList["\(indexPath.section)"]![indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
