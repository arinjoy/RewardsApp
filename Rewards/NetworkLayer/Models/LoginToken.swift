//
//  LoginToken.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation

/// A data structure for Login outcome or Token information ideally
struct LoginToken: Decodable {
    
    /// The status string which says "Ok" if succeeds
    let status: String
    
    // Poteitally there could be more OAuth attributes like:
    // - Access token
    // - Refresh token
    // - Expiry interval
}
