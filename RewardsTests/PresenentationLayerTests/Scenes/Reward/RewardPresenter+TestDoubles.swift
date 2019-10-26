//
//  RewardPresenter+TestDoubles.swift
//  RewardsTests
//
//  Created by Arinjoy Biswas on 27/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import Foundation
@testable import Rewards

// MARK: - Display Dummy

final class RewardDisplayDummy: RewardDisplay {
    func setTitle(_ title: String) {}
    func setAnimationContent(fromName name: String) {}
}

// MARK: - Display Spy

final class RewardDisplaySpy: RewardDisplay {
    
    // Spied calls
    var setTitleCalled: Bool = false
    var setAnimationContentCalled: Bool = false
    
    // Spied values
    var title: String?
    var animationName: String?
    
    func setTitle(_ title: String) {
        setTitleCalled = true
        self.title = title
    }
    
    func setAnimationContent(fromName name: String) {
        setAnimationContentCalled = true
        animationName = name
    }
}
