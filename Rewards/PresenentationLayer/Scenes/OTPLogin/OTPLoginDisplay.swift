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
    
    /// Will set the code input field placeholder
    ///
    /// - Parameter title: The placeholder to set
    func setCodeInputPlaceHolder(_ placeholder: String)
    
    /// Will show inline error message to input field
    ///
    /// - Parameter message: The message to show
    func showCodeInputError(message: String)

}
