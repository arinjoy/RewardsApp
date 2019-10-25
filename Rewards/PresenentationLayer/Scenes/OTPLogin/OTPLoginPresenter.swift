//
//  OTPLoginPresenter.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

protocol OTPLoginPresenting: class {
    
    /// Called when view did become ready
    func viewDidBecomeReady()
}

final class OTPLoginPresenter: OTPLoginPresenting {
    
    /// The front-facing view that conforms to the `OTPLoginDisplay` protocol
    weak var display: OTPLoginDisplay?
    
    // MARK: - Private Properties
    
    /// The interactor for login
    private let interactor: LoginInteracting
    
    init(interactor: LoginInteracting) {
        self.interactor = interactor
    }
    
    /// MARK: - OTPLoginPresenting
    
    func viewDidBecomeReady() {
        
        display?.setTitle(StringKeys.RewardsApp.otpLoginViewTitle.localized())
        
        display?.setCodeInputPlaceholder(
            StringKeys.RewardsApp.otpLoginInputPlaceholder.localized(),
            andTitle: StringKeys.RewardsApp.otpLoginInputTitle.localized()
        )
        
        /*
        interactor.doLogin(withOTP: "1234") { result in
            switch result {
            case .success(let suc):
                print(suc)
            case .failure(let err):
                print(err)
            }
        }
       */
        
    }
}
