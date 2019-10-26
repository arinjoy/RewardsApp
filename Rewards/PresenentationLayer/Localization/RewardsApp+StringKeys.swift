//
//  RewardsApp+StringKeys.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation

extension StringKeys {
    
    enum RewardsApp: String, LocalizationKeys {
        
        // MARK: - General
        
        case generalErrorMessage = "error.general.message"
        case networkConnectionErrorMessage = "error.networkConnection.message"
        
        
        // MARK: - OTP Login related
        
        case otpLoginViewTitle = "otpLogin.view.title"
        
        case otpLoginInputPlaceholder = "otpLogin.input.placeholder"
        case otpLoginInputTitle = "otpLogin.input.title"
        case otpLoginInputInvalidMessage = "otpLogin.input.error.invalidCode.message"
        
        case otpLoginProgressTitle = "otpLogin.progress.title"
        
        // MARK: - LocalizationKeys
        
        var table: String? { return "RewardsApp" }
    }
}

