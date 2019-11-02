//
//  RewardPresenterSpec.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 27/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Quick
import Nimble
@testable import Rewards

final class RewardPresenterSpec: QuickSpec {
    
    override func spec() {
        
        describe("Reward Presenter Spec") {
            
            var presenter: RewardPresenter!
            
            it("should call the display methods when view did become ready") {
                
                var displaySpy: RewardDisplaySpy!
                
                presenter = RewardPresenter()
                displaySpy = RewardDisplaySpy()
                presenter.display = displaySpy
                
                // when
                presenter.viewDidBecomeReady()
                
                // then
                expect(displaySpy.setTitleCalled) == true
                expect(displaySpy.title) == "Reward"
                
                expect(displaySpy.setAnimationContentCalled) == true
                expect(displaySpy.animationName) == "deer"
            }
        }
    }
}
