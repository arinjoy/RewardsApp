//
//  ApiClient.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Alamofire

/// A base class for API Client
class ApiClient {
    
    /// The Alamofire session manager
    var manager: SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        // Reducing standard timeout up to 5 sec
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        // Any more customization for network call can be done here
        self.manager = Alamofire.SessionManager(configuration: configuration)
    }
}

/// A client that handles Rewards API related requests
final class RewardsApiClient: ApiClient {

    func login() {
        
        let input = LoginInput(code: "1111")
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(input) {
            
            var request = URLRequest(url: URL(string: Constant.ApiConfig.serverLoginPath)!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = jsonData
            
            Alamofire.request(request)
                .responseData { response in
                    let decoder = JSONDecoder()
                    let todo: Result<LoginStatus> = decoder.decodeResponse(from: response)
                    print(todo)
            }
        }
        
    }
}




