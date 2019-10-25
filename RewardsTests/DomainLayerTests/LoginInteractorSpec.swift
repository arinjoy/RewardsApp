//
//  LoginInteractorSpec.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import Rewards

final class LoginInteractorSpec: QuickSpec {
    
    var result: LoginState!
    var error: APIError!
    
    var disposeBag: DisposeBag!
    
    override func spec() {
        
        describe("Login interactor spec") {
            

            beforeEach {
                self.disposeBag = DisposeBag()
            }
            
            afterEach {
                self.result = nil
                self.error = nil
                self.disposeBag = nil
            }
            
            it("should call Identity Service correctly") {
                
                let serviceSpy = IdentityServiceClientSpy()
                
                let loginInteractor = LoginInteractor(identityService: serviceSpy)
                
                // when
                loginInteractor.doLogin(withOTP: "5555", completion: { _ in
                })
                
                // then
                expect(serviceSpy.otpLoginCalled).toEventually(beTrue())
                expect(serviceSpy.otpLoginPin).toEventually(equal("5555"))
            }
            
            context("Identity service failed") {
                
                it("should return the error correctly for any general error") {
                    
                    let serviceMock = IdentityServiceClientMock(returningError: true, error: APIError.networkFailure)
                    
                    let loginInteractor = LoginInteractor(identityService: serviceMock)
                    
                    // when
                    loginInteractor.doLogin(withOTP: "1222", completion: { result in
                        switch result {
                        case .success(let result):
                            self.result = result
                        case .failure(let error):
                            self.error = error
                        }
                    })
                    
                    // then
                    expect(self.result).toEventually(beNil())
                    
                    expect(self.error).toNotEventually(beNil())
                    expect(self.error).toEventually(equal(APIError.networkFailure))
                }
                
                it("should return the correct result when login failed due to `unauthorized` error") {
                    
                    let serviceMock = IdentityServiceClientMock(
                        returningError: true,
                        error: APIError.unAuthorized)
                    
                    let loginInteractor = LoginInteractor(identityService: serviceMock)
                    
                    // when
                    loginInteractor.doLogin(withOTP: "1222", completion: { result in
                        switch result {
                        case .success(let result):
                            self.result = result
                        case .failure(let error):
                            self.error = error
                        }
                    })
                    
                    // then
                    expect(self.error).toEventually(beNil())
                    
                    expect(self.result).toNotEventually(beNil())
                    expect(self.result).toEventually(equal(LoginState.loginFailed))
                }
                
                it("should return the correct result when login was successful") {
                    
                    let serviceMock = IdentityServiceClientMock(returningError: false)
                    
                    let loginInteractor = LoginInteractor(identityService: serviceMock)
                    
                    // when
                    loginInteractor.doLogin(withOTP: "1222", completion: { result in
                        switch result {
                        case .success(let result):
                            self.result = result
                        case .failure(let error):
                            self.error = error
                        }
                    })
                    
                    // then
                    expect(self.error).toEventually(beNil())
                    
                    expect(self.result).toNotEventually(beNil())
                    expect(self.result).toEventually(equal(LoginState.loggedIn))
                }
            }
        }
    }
}
