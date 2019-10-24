//
//  IdentityService+OTP.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 24/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import RxSwift
import Alamofire

class IdentityService {
    
    
    /// Performs an OTP based login
    ///
    /// - Parameter pin: The pin to validate
    /// - Returns: `Observable` in terms of success/failure state
    func otpLogin(withPin pin: String) -> Observable<LoginToken> {
        
        let otpLoginURL = EndpointConfiguration.absoluteURL(for: .login)
        
        let otpLoginRequest = OTPLoginRequest(url: otpLoginURL, pin: pin)
        
         return Observable.create { observer -> Disposable in
            
            Alamofire.request(otpLoginRequest.urlRequest)
                .responseData { response in
                    let decoder = JSONDecoder()
                    let result: Result<LoginToken> = decoder.decodeResponse(from: response)
                    switch result {
                    case .success(let token):
                        observer.onNext(token)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create()
         }
    }
}

