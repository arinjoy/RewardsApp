//
//  OTPLoginInput.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation

/// A data structure for OTP Login request body
struct OTPLoginInput: Encodable {
    
    /// Tye user typed code to send for authetication
    let code: String
}
