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
    
    /// Called when login is submitted
    func didSubmitLogin(withCode code: String)
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
    }
    
    func didSubmitLogin(withCode code: String) {
        
        display?.showProcessingIndicator(
            withMessage: StringKeys.RewardsApp.otpLoginProgressTitle.localized())
        
        interactor.doLogin(withOTP: code) { [weak self] result in
            switch result {
            case .success(let status):
                switch status {
                case.loggedIn:
                    self?.display?.showProcessingIndicatorSuccess()
                    self?.display?.hideProcessingIndicator(afterDelay: 1.0)
                
                case .loginFailed:
                    self?.display?.showProcessingIndicatorFailure()
                    self?.display?.hideProcessingIndicator(afterDelay: 1.0)
                }
                
            case .failure(let error):
                switch error {
                case .networkFailure:
                    self?.display?.showErrorMessage(
                        StringKeys.RewardsApp.networkConnectionErrorMessage.localized())
                default:
                    // TODO: More custom error detection and handling can be done here
                
                    self?.display?.showErrorMessage(
                        StringKeys.RewardsApp.generalErrorMessage.localized())
                }
            }
        }
    }
}
