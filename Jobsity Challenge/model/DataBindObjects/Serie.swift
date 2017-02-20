//
//  Serie.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation

class Serie {
    
    var id = ""
    var name = ""
    var language = ""
    var genres: [String] = []
    var coverImgURL: String?
    
    var posterImgURL: String?
    var time = ""
    var days: [String] = []
    var summary = ""
    
    
    init(id: String,
         name: String,
         language: String,
         genres: [String],
         coverImgURL: String?,
         posterImgURL: String?,
         time: String,
         days: [String],
         summary: String) {
        
        self.id = id
        self.name = name
        self.language = language
        self.genres = genres
        self.coverImgURL = coverImgURL
        self.posterImgURL = posterImgURL
        self.time = time
        self.days = days
        self.summary = summary
    }
    
}
