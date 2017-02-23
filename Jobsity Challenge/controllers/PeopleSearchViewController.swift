//
//  PeopleSearchTableViewController.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/22/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import UIKit

class PeopleSearchViewController: UIViewController {
    
    fileprivate var searchBar = UISearchBar()
    fileprivate var people: [Person] = []
    @IBOutlet var progress: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        progress.stopAnimating()
        createSearchBar()
        tableView.register(UINib.init(nibName: "PeopleSearchTableCell", bundle: Bundle.main), forCellReuseIdentifier: "peopleListTableViewCell")
        tableView.keyboardDismissMode = .onDrag
    }
    
    func createSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search people"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func showAlertView(withMessage message: String, andTitle error: String) {
        let alertController = UIAlertController(title: error, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

extension PeopleSearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Search bar delegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        progress.startAnimating()
        progress.isHidden = false
        tableView.isHidden = true
        PeopleConnection().listPeople(fromServiceURL: Constants.SEARCH_PEOPLE + searchBar.text!) { [unowned self] data in
            if data == nil {
                self.showAlertView(withMessage: "Data is nil", andTitle: "Error")
            } else if (data is Error) {
                self.showAlertView(withMessage: "Error: \n\(data as! Error)", andTitle: "Error")
            } else if data is [Person] {
                self.progress.stopAnimating()
                self.tableView.isHidden = false
                let peopleList = data as! [Person]
                self.people = peopleList
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placeholderImg = UIImage(named: "placeholder_img.jpg")
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleListTableViewCell", for: indexPath) as! PeopleListTableViewCell
        cell.peopleNameLabel.text = people[indexPath.row].name
        cell.peopleImageView.image = placeholderImg
        if let imgURL = people[indexPath.row].imageURL {
            cell.peopleImageView.af_setImage(withURL: URL(string: imgURL)!, placeholderImage: placeholderImg)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 229
    }
    
}
