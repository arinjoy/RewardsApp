//
//  OTPLoginPresenter.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import RxSwift

protocol OTPLoginPresenting: class {
    
    /// Called when view did become ready
    func viewDidBecomeReady()

}

final class OTPLoginPresenter: OTPLoginPresenting {
    
    /// The front-facing view that conforms to the `OTPLoginDisplay` protocol
    weak var display: OTPLoginDisplay?
    
    /// The identity service for login
    private let service = IdentityServiceClient(dataSource: HTTPClient())
    
    /// The RxSwift disposing swift
    private let disposeBag = DisposeBag()
    
    
    /// MARK: - OTPLoginPresenting
    
    func viewDidBecomeReady() {
        
        display?.setTitle(StringKeys.RewardsApp.otpLoginViewTitle.localized())
        
        display?.setCodeInputPlaceHolder(
            StringKeys.RewardsApp.otpLoginInputPlaceholder.localized()
        )
    }
}
