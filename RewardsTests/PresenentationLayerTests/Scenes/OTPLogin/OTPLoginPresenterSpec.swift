//
//  OTPLoginPresenterSpec.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Quick
import Nimble
@testable import Rewards

final class OTPLoginPresenterSpec: QuickSpec {
    
    override func spec() {
        
        describe("OTP Login Presenter Spec") {
            
            var presenter: OTPLoginPresenter!
        
            it("should call the display methods when view did become ready") {
                
                var displaySpy: OTPLoginDisplaySpy!
                
                presenter = OTPLoginPresenter(interactor: LoginInteractorDummy())
                displaySpy = OTPLoginDisplaySpy()
                presenter.display = displaySpy
                
                // when
                presenter.viewDidBecomeReady()
                
                // then
                expect(displaySpy.setTitleCalled) == true
                expect(displaySpy.title) == "Please enter your OTP"

                expect(displaySpy.setCodeInputPlaceholderCalled) == true
                expect(displaySpy.codeInputplaceholder) == "Enter OTP"
                expect(displaySpy.codeInputTitle) == "4 DIGIT CODE"
            }
            
            context("communication with interactor") {
                
                var interactorSpy: LoginInteractorSpy!
                var displayDummy: OTPLoginDisplayDummy!
                
                it("should talk to interactor upon submission of OTP code") {
                    
                    interactorSpy = LoginInteractorSpy()
                    displayDummy = OTPLoginDisplayDummy()
                    presenter = OTPLoginPresenter(interactor: interactorSpy)
                    presenter.display = displayDummy
                    
                    // when
                    presenter.didSubmitLogin(withCode: "2222")
                    
                    // then
                    expect(interactorSpy.doLoginCalled) == true
                    expect(interactorSpy.otpCode) == "2222"
                }
            }
            
            context("communication with display on interactor behaviours") {
                
                var interactorMock: LoginInteractorMock!
                var displaySpy: OTPLoginDisplaySpy!
                
                it("should show the processing indicator when OTP submission was made") {
                    
                    interactorMock = LoginInteractorMock()
                    presenter = OTPLoginPresenter(interactor: interactorMock)
                    displaySpy = OTPLoginDisplaySpy()
                    presenter.display = displaySpy
                    
                    // when
                    presenter.didSubmitLogin(withCode: "2222")
                    
                    // then
                    expect(displaySpy.showProcessingIndicatorCalled) == true
                    expect(displaySpy.processingIndicatorMessage) == "Logging you in ..."
                }
                
                it("should show failure indicator when interactor login failed") {
                    
                    interactorMock = LoginInteractorMock(result: .loginFailed)
                    
                    presenter = OTPLoginPresenter(interactor: interactorMock)
                    displaySpy = OTPLoginDisplaySpy()
                    presenter.display = displaySpy
                    
                    // when
                    presenter.didSubmitLogin(withCode: "2222")
                    
                    // then
                    expect(displaySpy.hideProcessingIndicatorCalled)
                        .toEventually(beTrue())
                    expect(displaySpy.showProcessingIndicatorFailureCalled)
                        .toEventually(beTrue())
                }
                
                it("should show success indicator when interactor login succeeded") {
                    
                    interactorMock = LoginInteractorMock(
                        result: .loggedIn)
                    
                    presenter = OTPLoginPresenter(interactor: interactorMock)
                    displaySpy = OTPLoginDisplaySpy()
                    presenter.display = displaySpy
                    
                    // when
                    presenter.didSubmitLogin(withCode: "2222")
                    
                    // then
                    expect(displaySpy.hideProcessingIndicatorCalled)
                        .toEventually(beTrue())
                    expect(displaySpy.showProcessingIndicatorSuccessCalled)
                        .toEventually(beTrue())
                }
                
                it("should show general error message when interactor login came back general server error") {
                    
                    interactorMock = LoginInteractorMock(resultingError: true,
                                                         error: APIError.server)
                    
                    presenter = OTPLoginPresenter(interactor: interactorMock)
                    displaySpy = OTPLoginDisplaySpy()
                    presenter.display = displaySpy
                    
                    // when
                    presenter.didSubmitLogin(withCode: "2222")
                    
                    // then
                    expect(displaySpy.showErrorMessageCalled)
                        .toEventually(beTrue())
                    expect(displaySpy.errorMessage)
                        .toEventually(equal("Oops.\n\nSomething went wrong!"))
                }
                
                it("should show network connection error message when interactor login came back with `networkFailure`") {
                    
                    interactorMock = LoginInteractorMock(resultingError: true,
                                                         error: APIError.networkFailure)
                    
                    presenter = OTPLoginPresenter(interactor: interactorMock)
                    displaySpy = OTPLoginDisplaySpy()
                    presenter.display = displaySpy
                    
                    // when
                    presenter.didSubmitLogin(withCode: "2222")
                    
                    // then
                    expect(displaySpy.showErrorMessageCalled)
                        .toEventually(beTrue())
                    expect(displaySpy.errorMessage)
                        .toEventually(equal("Oops.\n\nPlease check network connection."))
                }
            }
        }
    }
}
