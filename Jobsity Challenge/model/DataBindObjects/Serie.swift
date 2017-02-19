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
    var coverImgURL = ""
    
    init(id: String, name: String, language: String, genres: [String], coverImgURL: String) {
        self.id = id
        self.name = name
        self.language = language
        self.genres = genres
        self.coverImgURL = coverImgURL        
    }
    
}
