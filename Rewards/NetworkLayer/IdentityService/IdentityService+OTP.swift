//
//  IdentityService+OTP.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 24/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import RxSwift

protocol IdentityServiceClientType {
    func otpLogin(withPin pin: String) -> Single<LoginToken>
}

class IdentityServiceClient: IdentityServiceClientType {
    
    private let dataSource: ObservableDataSource
    
    init(dataSource: ObservableDataSource) {
        self.dataSource = dataSource
    }
    
    /// Performs an OTP based login
    ///
    /// - Parameter pin: The pin to validate
    /// - Returns: `Observable` in terms of success/failure state
    func otpLogin(withPin pin: String) -> Single<LoginToken> {
        
        let otpLoginURL = EndpointConfiguration.absoluteURL(for: .login)
        
        let otpLoginRequest = OTPLoginRequest(url: otpLoginURL, pin: pin)
        
        return dataSource.fetchSingleObject(with: otpLoginRequest)
    }
}

