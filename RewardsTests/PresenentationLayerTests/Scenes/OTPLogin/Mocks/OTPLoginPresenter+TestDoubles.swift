//
//  OTPLoginPresenter+TestDoubles.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation
@testable import Rewards

// MARK: - Display dummy

final class OTPLoginDisplayDummy: OTPLoginDisplay {
    func setTitle(_ title: String) {}
    func setCodeInputPlaceholder(_ placeholder: String, andTitle title: String) {}
    func showProcessingIndicator(withMessage message: String) {}
    func showProcessingIndicatorSuccess() {}
    func showProcessingIndicatorFailure() {}
    func hideProcessingIndicator(afterDelay delay: TimeInterval) {}
    func showErrorMessage(_ message: String) {}
    func showCodeInputError(message: String?) {}
}

// MARK: - Display spy

final class OTPLoginDisplaySpy: OTPLoginDisplay {
    
    // Spied calls
    var setTitleCalled: Bool = false
    var setCodeInputPlaceholderCalled: Bool = false
    var showProcessingIndicatorCalled: Bool = false
    var showProcessingIndicatorSuccessCalled: Bool = false
    var showProcessingIndicatorFailureCalled: Bool = false
    var hideProcessingIndicatorCalled: Bool = false
    var showErrorMessageCalled: Bool = false
    var showCodeInputErrorCalled: Bool = false
    
    // Spied values
    var title: String?
    var codeInputplaceholder: String?
    var codeInputTitle: String?
    var processingIndicatorMessage: String?
    var hideProcessingIndicatorDelay: TimeInterval?
    var errorMessage: String?
    var codeInputErrorMessage: String?
    
    
    func setTitle(_ title: String) {
        setTitleCalled = true
        self.title = title
    }
    
    func setCodeInputPlaceholder(_ placeholder: String, andTitle title: String) {
        setCodeInputPlaceholderCalled = true
        codeInputplaceholder = placeholder
        codeInputTitle = title
    }
    
    func showProcessingIndicator(withMessage message: String) {
        showProcessingIndicatorCalled = true
        processingIndicatorMessage = message
    }
    
    func showProcessingIndicatorSuccess() {
        showProcessingIndicatorSuccessCalled = true
    }
    
    func showProcessingIndicatorFailure() {
        showProcessingIndicatorFailureCalled = true
    }
    
    func hideProcessingIndicator(afterDelay delay: TimeInterval) {
        hideProcessingIndicatorCalled = true
        hideProcessingIndicatorDelay = delay
    }
    
    func showErrorMessage(_ message: String) {
        showErrorMessageCalled = true
        errorMessage = message
    }
    
    func showCodeInputError(message: String?) {
        showCodeInputErrorCalled = true
        codeInputErrorMessage = message
    }
}

// MARK: - Interactor Dummy

final class LoginInteractorDummy: LoginInteracting {
    
    func doLogin(
        withOTP code: String,
        completion: @escaping ((Result<LoginState, APIError>) -> Void)
    ) {}
}

// MARK: - Interactor Spy

final class LoginInteractorSpy: LoginInteracting {
    
    var doLoginCalled: Bool = false
    var otpCode: String?
    
    func doLogin(
        withOTP code: String,
        completion: @escaping ((Result<LoginState, APIError>) -> Void)
    ) {
        doLoginCalled = true
        otpCode = code
    }
}

// MARK: - Interactor Mock

final class LoginInteractorMock: LoginInteracting {
    
    var resultingError: Bool
    var error: APIError
    var result: LoginState
    
    init(
        resultingError: Bool = false,
        error: APIError = .unknown,
        result: LoginState = .loggedIn
    ) {
        self.resultingError = resultingError
        self.error = error
        self.result = result
    }
    
    func doLogin(
        withOTP code: String,
        completion: @escaping ((Result<LoginState, APIError>) -> Void)
    ) {
        if resultingError {
            completion(Result.failure(self.error))
        } else {
             completion(Result.success(self.result))
        }
    }
}


