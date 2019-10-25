//
//  IdentityService+TestDoubles.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation
import RxSwift
@testable import Rewards

// MARK: - Spy

final class IdentityServiceClientSpy: IdentityServiceClientType {

    // Spied call
    var otpLoginCalled: Bool = false
    
    // Spied value
    var otpLoginPin: String?
    
    func otpLogin(withPin pin: String) -> Single<LoginToken> {
        otpLoginCalled = true
        otpLoginPin = pin
        
        return Observable.empty().asSingle()
    }
}


// MARK: - Mock

final class IdentityServiceClientMock: IdentityServiceClientType {
    
    /// Whether to return error outcome
    let returningError: Bool
    
    /// The pre-determined error to return if `returnError` is set true
    let error: Error
    
    init(
        returningError: Bool = false,
        error: Error = APIError.unknown
    ) {
        self.returningError = returningError
        self.error = error
    }
    
    func otpLogin(withPin pin: String) -> Single<LoginToken> {

        if returningError {
            return Single.error(error)
        }
        
        return Single<LoginToken>.just(self.sampleLoginToken())
    }
    
    // MARK: - Private Test Helpers
    
    private func sampleLoginToken() -> LoginToken {
        return LoginToken(status: "Okay")
    }
}
