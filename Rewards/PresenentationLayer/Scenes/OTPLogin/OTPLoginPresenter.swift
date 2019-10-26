//
//  OTPLoginPresenter.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit

protocol OTPLoginPresenting: class {
    
    /// Called when view did become ready
    func viewDidBecomeReady()
    
    /// Called when code input field did enter typing
    func codeInputDidEnterTyping()
    
    /// Called as the code input field data entry occurs
    func codeInputDidEnterText(_ text: String?)
    
    /// Called when login is submitted
    func didSubmitLogin(withCode code: String)
}

final class OTPLoginPresenter: OTPLoginPresenting {
    
    /// The front-facing view that conforms to the `OTPLoginDisplay` protocol
    weak var display: OTPLoginDisplay?
    
    /// The routing instance for the presenter
    var router: OTPLoginRouting?
    
    // Constant
    let codeInputMaxLength: Int = 4
    
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
    
    func codeInputDidEnterTyping() {
        display?.hideCodeInputError()
    }
    
    func codeInputDidEnterText(_ text: String?) {
        if let trimmedText = text?.trimmingCharacters(in: .whitespacesAndNewlines),
            trimmedText.count < codeInputMaxLength {
            display?.enableSubmitButton(false)
        } else {
            display?.enableSubmitButton(true)
        }
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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        self?.router?.routeToRewardScene()
                    })
                
                case .loginFailed:
                    
                    self?.display?.showProcessingIndicatorFailure()
                    self?.display?.hideProcessingIndicator(afterDelay: 1.0)
                    
                    self?.display?.showCodeInputError(
                        message: StringKeys.RewardsApp.otpLoginInputInvalidMessage.localized()
                    )
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
