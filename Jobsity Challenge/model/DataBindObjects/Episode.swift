//
//  SerieDetail.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/20/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation

class Episode {
    
    var id = ""
    var name = ""
    var number = 0
    var season = ""
    var summary: String?
    var imageURL: String?
    
    init(id: String,
         name: String,
         number: Int,
         season: String,
         summary: String?,
         imageURL: String?) {
        self.id = id
        self.name = name
        self.number = number
        self.season = season
        self.summary = summary
        self.imageURL = imageURL
    }    
}
