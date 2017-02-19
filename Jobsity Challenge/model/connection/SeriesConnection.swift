//
//  SeriesConnection.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation

class SeriesConnection: Connection {
    
    func listSeries(fromServiceURL url: String, completion: @escaping (_ data: [Serie]?) -> ()) {
        super.fetchData(fromURL: url) { [unowned self] data in
            completion(self.bindData(data))
        }
    }
    
    private func bindData(_ data: [[String:NSObject]]?) -> [Serie] {
        
    }
    
}
