//
//  ObservableDataSource+TestDoubles.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation
import RxSwift
@testable import Rewards

// MARK: - Spy

final class ObservableDataSourceSpy: ObservableDataSource {
    
    var fetchSingleObjectCalled = false
    var request: BaseRequest?
    
    func fetchSingleObject<T>(with request: BaseRequest) -> PrimitiveSequence<SingleTrait, T> where T : Decodable {
        fetchSingleObjectCalled = true
        self.request = request
        return Observable.empty().asSingle()
    }
}

// MARK: - Mock

final class ObservableDataSourceMock<ResponseType>: ObservableDataSource {
    
    /// The pre-determined response to always return from this mock no matter what request is made
    let response: ResponseType
    
    /// Whether to return error outcome
    let returningError: Bool
    
    /// The pre-determined error to return if `returnError` is set true
    let error: Error
    
    init(
        response: ResponseType,
        returningError: Bool = false,
        error: Error = APIError.seviceUnavailable
    ) {
        self.response = response
        self.returningError = returningError
        self.error = error
    }
    
    func fetchSingleObject<T>(with request: BaseRequest) -> PrimitiveSequence<SingleTrait, T> where T : Decodable {
        if returningError {
            return Single.error(error)
        }
        return Single<ResponseType>.just(response) as! PrimitiveSequence<SingleTrait, T>
    }
}
