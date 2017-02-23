//
//  PeopleConnection.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/22/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation

class PeopleConnection: Connection {
    
    func listPeople(fromServiceURL url: String, completion: @escaping (Any?) -> ()) {
        super.fetchData(fromURL: url) { data in
            completion(self.bindData(data))
        }
    }
    
    fileprivate func bindData(_ data: Any?) -> Any? {
        
        var people: [Person] = []
        
        guard let _ = data else {
            return nil
        }
        
        guard !(data is Error) else {
            return data as! Error
        }
        
        if let peopleList = data as? [[String:NSObject]] {
            for person in peopleList {
                let id = String(describing: (person["person"] as! [String:NSObject])["id"]!)
                let name = (person["person"] as! [String:NSObject])["name"] as! String
                var imageURL: String?
                if let imgURL = (person["person"] as! [String:NSObject])["image"] as? [String:String] {
                    imageURL = imgURL["original"]!
                }
                
                people.append(Person(id: id, name: name, imageURL: imageURL))
            }
            
        }
        
        return people
    }
    
}
