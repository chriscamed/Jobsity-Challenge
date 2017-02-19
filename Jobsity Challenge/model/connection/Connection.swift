//
//  Connection.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation
import Alamofire

class Connection {
    
    func fetchData(fromURL url: String, completion: @escaping (_ data: [[String:NSObject]]?) -> ()) {
        Alamofire.request(url).responseJSON { response in
            print(response.request)
            print(response.result)
            
            if let JSON = response.result.value as? [[String:NSObject]] {
                completion(JSON)
            }
        }
    }
}
