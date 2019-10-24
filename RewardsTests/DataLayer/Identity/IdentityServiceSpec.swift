//
//  IdentityServiceSpec.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import Rewards

final class IdentityServiceSpec: QuickSpec {
    
    override func spec() {
        
        describe("Indentity service spec") {
            
            var disposeBag: DisposeBag!
            
            beforeEach {
                disposeBag = DisposeBag()
            }
            
            afterEach {
                disposeBag = nil
            }
            
            it("should call a post request on the api client") {
                
                let dataSourceSpy = ObservableDataSourceSpy()
                
                let service = IdentityServiceClient(dataSource: dataSourceSpy)
                
                // when
                service.otpLogin(withPin: "1111")
                    .subscribe()
                    .disposed(by: disposeBag)
                
                // then
                expect(dataSourceSpy.fetchSingleObjectCalled).to(beTrue())
                
                expect(dataSourceSpy.request?.urlRequest.httpMethod)    .to(equal(HTTPRequestMethod.post.rawValue))
                
                expect(dataSourceSpy.request?.urlRequest.url)
                    .to(equal(EndpointConfiguration.absoluteURL(for: .login)))
                
            }
            
            it("should pass the response from the api client unchanged when succeeds") {
                
                let dataSourceMock = ObservableDataSourceMock(
                    response: self.sampleLoginToken(),
                    returningError: false  // No error returned, means response is returned with success
                )
                var expectedError: Error?
                var receivedResponse: LoginToken?
                
                let service = IdentityServiceClient(dataSource: dataSourceMock)
                
                // when
                service.otpLogin(withPin: "1111")
                    .subscribe(onSuccess: { response in
                        receivedResponse = response
                    }, onError: { error in
                        expectedError = error
                    }).disposed(by: disposeBag)
                
                // then
                expect(expectedError).to(beNil())
                expect(receivedResponse).toNot(beNil())
                expect(receivedResponse?.status) == "OK"
            }
            
            it("should pass error from the api client when fails") {
            
                let dataSourceMock = ObservableDataSourceMock(
                    response: self.sampleLoginToken(),
                    returningError: true,  // Error returned, means no response is returned due to failure,
                    error: APIError.server
                )
                var expectedError: Error?
                var receivedResponse: LoginToken?
                
                let service = IdentityServiceClient(dataSource: dataSourceMock)
                
                // when
                service.otpLogin(withPin: "1111")
                    .subscribe(onSuccess: { response in
                        receivedResponse = response
                    }, onError: { error in
                        expectedError = error
                    }).disposed(by: disposeBag)
                
                // then
                expect(receivedResponse).to(beNil())
                expect(expectedError).toNot(beNil())
                expect(expectedError as? APIError).to(equal(APIError.server))
                
            }
        }
    }
    
    // MARK: - Private Test Helpers
    
    private func sampleLoginToken() -> LoginToken {
        return LoginToken(status: "OK")
    }
}
