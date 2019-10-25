//
//  OTPLoginRequest.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 24/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation

final class OTPLoginRequest: BaseRequest {
    
    var urlRequest: URLRequest
    
    init(url: URL, pin: String) {
       
        urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = HTTPRequestMethod.post.rawValue
        
        let bodyInput = OTPLoginInput(code: pin)
        if let jsonData = try? JSONEncoder().encode(bodyInput) {
            urlRequest.httpBody = jsonData
        }
    }
}
