//
//  OTPLoginDisplay.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation

protocol OTPLoginDisplay: class {

    /// Will set the main title within the view
    ///
    /// - Parameter title: The title to set
    func setTitle(_ title: String)
    
    /// Will set the code input field placeholder & top title while editing
    ///
    /// - Parameter placeholder: The placeholder to set
    /// - Parameter title: The title to set on top of it while editing
    func setCodeInputPlaceholder(_ placeholder: String, andTitle title: String)
    
    /// Will start showing processing spinner with a message
    ///
    /// - Parameter message: The message to show while processing
    func showProcessingIndicator(withMessage message: String)
    
    /// Called to show a success mark after processing finished
    func showProcessingIndicatorSuccess()
    
    /// Called to show a error mark after processing finished
    func showProcessingIndicatorFailure()
    
    /// Called to hide the processing spinner after a delay specified
    /// - Parameter delay: The delay in terms seconds
    func hideProcessingIndicator(afterDelay delay: TimeInterval)
    
    /// Called to show an error message to the main view
    func showErrorMessage(_ message: String)
    
    /// Called to show an inline error message on the input field
    ///
    /// - Parameter message: The message to show. `nil` value would hide the error
    func showCodeInputError(message: String?)
    
    /// Called to hide code input inline error
    func hideCodeInputError()
    
    /// Called to enable/diable the submit button
    func enableSubmitButton(_ enabled: Bool)
}
