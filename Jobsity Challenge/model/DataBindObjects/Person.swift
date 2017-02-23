//
//  Person.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/22/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation

class Person {
    
    var id: String!
    var name: String!
    var imageURL: String?
    
    init(id: String, name: String, imageURL: String?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
}
