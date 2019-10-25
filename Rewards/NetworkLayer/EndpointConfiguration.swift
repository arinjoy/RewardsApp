//
//  EndpointConfiguration.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case login = "https://floral-cherry-7673.getsandbox.com/login"
}

struct EndpointConfiguration {
    
    static func absoluteURL(for endpoint: Endpoint) -> URL {
        
        guard let url = URL(string: endpoint.rawValue) else {
            fatalError("\(endpoint.rawValue) must be incorrect")
        }
        
        return url
    }
}

