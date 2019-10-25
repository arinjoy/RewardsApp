//
//  OTPLoginDisplay.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

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
    
    /// Will show inline error message to input field
    ///
    /// - Parameter message: The message to show. `nil` value would hide the error
    func showCodeInputError(message: String?)
}
