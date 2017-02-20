//
//  EpisodesConnection.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/20/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation

class EpisodesConnection: Connection {
    
    private var currentSeason = "1"
    
    func listEpisodes(fromServiceURL url: String, completion: @escaping (Any?) -> ()) {
        super.fetchData(fromURL: url) { data in
            completion(self.bindData(data))
        }
    }
    
    private func bindData(_ data: Any?) -> Any? {
        
        var episodesBySeason: [String:[Episode]] = [:]
        var episodes: [Episode] = []
        
        guard let _ = data else {
            return nil
        }
        
        guard !(data is Error) else {
            return data as! Error
        }
        
        if let episodesArray = data as? [[String:NSObject]] {
            for episode in episodesArray {
                let id = String(describing: episode["id"]!)
                let name = episode["name"] as! String
                let number = episode["number"] as! Int
                let season = String(describing: episode["season"]!)
                let summary = episode["summary"] as! String
                var imageURL: String?
                if let imgURL = episode["image"] as? [String:String] {
                    imageURL = imgURL["original"]!
                }
                
                if season != currentSeason {
                    episodesBySeason["\(currentSeason)"] = episodes
                    episodes = []
                    currentSeason = season
                }
                
                episodes.append(Episode(id: id, name: name, number: number, season: season, summary: summary, imageURL: imageURL))
            }
            
            episodesBySeason["\(currentSeason)"] = episodes
            
        }
        
        return episodesBySeason
    }
    
}
