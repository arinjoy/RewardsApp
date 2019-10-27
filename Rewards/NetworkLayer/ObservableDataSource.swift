//
//  ObservableDataSource.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 24/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import RxSwift

/// Data tasks which address a server and optionally return a Data instance.
protocol ObservableDataSource {
    
    ///  Calls the server, fecthes and returns a `Single<Data>` instance.
    ///
    /// - Parameter request: A BaseRequest instance that defines the API call
    /// - Returns: a `Single<T>` instance containing the data returned from the API call
    @discardableResult
    func fetchSingleObject<T>(with request: BaseRequest) -> Single<T> where T: Decodable
    
}
