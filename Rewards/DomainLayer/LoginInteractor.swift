//
//  LoginInteractor.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation
import RxSwift

/// Enumeration of Login States
enum LoginState {
    case loggedIn
    case loginFailed
    
    // TODO: Case for Password Reset or other potential states around  reset/recovery
}

protocol LoginInteracting {
    
    /// Performs login with OTP code
    ///
    /// - Parameters:
    ///   - code: The code to authenticate
    ///   - completion: The completion callback with success/failure
    func doLogin(
        withOTP code: String,
        completion: @escaping ((Result<LoginState, APIError>) -> Void)
    )
    
    // TODO: This interactor may have other forms of login methods in future.
    // For example, login with UserName & Password, or with Biometric etc.
}

final class LoginInteractor: LoginInteracting {
    
    // RxSwift Disposebag
    private let disposeBag = DisposeBag()
    
    // MARK: - Private Propertires
    private let identityService: IdentityServiceClientType
    
    init(identityService: IdentityServiceClientType) {
        self.identityService = identityService
    }
    
    //let sss = IdentityServiceClient(dataSource: HTTPClient())
    
    func doLogin(
        withOTP code: String,
        completion: @escaping ((Result<LoginState, APIError>) -> Void)
    ) {
        
        identityService.otpLogin(withPin: code)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { token in
                
                // Do any necessary processing on token's internal
                // data if needed in future. For now, success means 200, i.e. Logged In
                completion(.success(LoginState.loggedIn))
                
            }, onError: { error in
                
                guard let apiError = error as? APIError else {
                    completion(.failure(APIError.unknown))
                    return
                }
                
                if apiError == .unAuthorized {
                    // If unauthorized, flag that as an outcome with desired state
                    completion(.success(LoginState.loginFailed))
                } else {
                    // For all other errors, just pass around the error to be handled
                    // by the receiver accordingly
                    completion(.failure(apiError))
                }
            })
            .disposed(by: disposeBag)
    }
}
