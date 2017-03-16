//
//  SeriesConnection.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation

class SeriesConnection: Connection {
    
	func listSeries(atPage page: String, completion: @escaping (Any?) -> ()) {
        let url = Constants.LIST_SHOWS_BY_PAGE + "\(page)"
        super.fetchData(fromURL: url) { data in
            completion(self.bindData(data, isPersonSeries: false))
        }
    }
    
    func listSeries(byPersonId id: String, completion: @escaping (Any?) -> ()) {
        let url = Constants.FETCH_PERSON_SERIES + id + Constants.CAST_CREDITS
        super.fetchData(fromURL: url) { data in
            completion(self.bindData(data, isPersonSeries: true))
        }
    }
	
	fileprivate func bindData(_ data: Any?, isPersonSeries: Bool) -> Any? {
        
        var series: [Serie] = []
        
        guard let _ = data else {
            return nil
        }
        
        guard !(data is Error) else {
            return data as! Error
        }
        
        if let seriesArray = data as? [[String: NSObject]] {
            for serieItem in seriesArray {
				var serie = serieItem
				if isPersonSeries {
					serie = (serieItem["_embedded"] as! [String: NSObject])["show"] as! [String: NSObject]
				}
                let id = String(describing: serie["id"]!)
                let name = serie["name"] as! String
                let language = serie["language"] as! String
                let genres = serie["genres"] as! [String]
                let time = (serie["schedule"] as! [String: NSObject])["time"]! as! String
                let days = (serie["schedule"] as! [String: NSObject])["days"]! as! [String]
                let summary = serie["summary"] as! String
                var coverImgURL: String?
                var posterImgURL: String?
                if let imgURL = serie["image"] as? [String: String] {
                    coverImgURL = imgURL["medium"]!
                }
                if let imgURL = serie["image"] as? [String: String] {
                    posterImgURL = imgURL["original"]!
                }
                                
                series.append(Serie(id: id,
                                    name: name,
                                    language: language,
                                    genres: genres,
                                    coverImgURL: coverImgURL,
                                    posterImgURL: posterImgURL,
                                    time: time,
                                    days: days,
                                    summary: summary))
            }
        }
        
        return series
    }
    
}
