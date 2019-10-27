//
//  OTPLoginRequestSpec.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 24/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Quick
import Nimble
@testable import Rewards

final class OTPLoginRequestSpec: QuickSpec {

    override func spec() {
        
        describe("OTPLoginRequestSpec") {
            
            context("when constrcuted") {
                
                let request = OTPLoginRequest(
                    url: EndpointConfiguration.absoluteURL(for: .login),
                    pin: "1234")
                
                it("should set the correct POST api call path") {
                    expect(request.urlRequest.httpMethod) == HTTPRequestMethod.post.rawValue
        
                    expect(request.urlRequest.url) == EndpointConfiguration.absoluteURL(for: .login)
                    
                    expect(request.urlRequest.timeoutInterval) == 10.0

                }
                
                it("should set the json data body correctly to the url request") {
                    
                    expect {
                        
                        // when
                        let data = request.urlRequest.httpBody
                    
                        // then
                        expect(data).toNot(beNil())
                        
                        let body = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                        
                        expect(body).toNot(beNil())
                        expect(body?.count).to(equal(1))
                        expect(body?["code"] as? String).to(equal("1234"))
                        
                        return nil
                    }.toNot(throwError())
                    
                }
            }
        }
    }
}
