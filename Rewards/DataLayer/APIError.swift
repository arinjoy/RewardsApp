//
//  APIError.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 24/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation

/// An enumeration of potential API related error
/// This can be elaborated in future
public enum APIError: Error {
    case unAuthorized
    case forbidden
    case seviceUnavailable
    case server
    case dataError
}
