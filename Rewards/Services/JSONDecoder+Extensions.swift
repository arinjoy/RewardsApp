//
//  JSONDecoder+Extensions.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case unAuthorized
    case parsingError
}

extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            return .failure(response.error!)
        }
        
        if let statusCode = response.response?.statusCode,
            statusCode == 401 {
            return .failure(APIError.unAuthorized)
        }
        
        guard let responseData = response.data else {
            return .failure(APIError.parsingError)
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            return .failure(error)
        }
    }
}
