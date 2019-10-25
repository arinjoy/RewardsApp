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
        
        case otpLoginViewTitle = "otpLogin.view.title"
        
        case otpLoginInputPlaceholder = "otpLogin.input.placeholder"

        
        // MARK: - LocalizationKeys
        
        var table: String? { return "RewardsApp" }
    }
}

