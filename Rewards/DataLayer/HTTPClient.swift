//
//  HTTPClient.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 24/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

final class HTTPClient: ObservableDataSource {
    
    @discardableResult func fetchSingleObject<T>(with request: BaseRequest) -> Single<T> where T: Decodable {
        
        return Single<T>.create { single in
            
            Alamofire.request(request.urlRequest)
                .responseData { response in
                    
                    let decoder = JSONDecoder()
                    let result: Result<T> = decoder.decodeResponse(from: response)
                    switch result {
                    case .success(let result):
                        single(.success(result))
                    case .failure(let error):
                        single(.error(error))
                    }
            }
            
            return Disposables.create()
        }
    }
}

extension JSONDecoder {
    
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        
        if let error = response.error {
            // Networking and API client related errors here
            return .failure(error)
        }
        
        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 401:
                return .failure(APIError.unAuthorized)
            case 403:
                return .failure(APIError.forbidden)
            case 503:
                return .failure(APIError.seviceUnavailable)
            case 500 ... 599:
                return .failure(APIError.server)
            default:
                break
            }
        }
        
        // Other than the above error cases,
        // we expect response may have some data (including error body sent from server)
        // If not, treat as missing data error
        guard let responseData = response.data else {
            return .failure(APIError.dataError)
        }
        
        // If response data body exists, try to decode from JSON as expected Data type
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            // Most likely JSON data/contract conversion error here
            // Or if a custom Error json body was sent from server
            return .failure(error)
        }
    }
}

