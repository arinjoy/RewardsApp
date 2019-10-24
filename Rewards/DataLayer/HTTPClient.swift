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

class HTTPClient: ObservableDataSource {
    
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
