//
//  RewardPresenter.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

protocol RewardPresenting: class {
    
    /// Called when view did become ready
    func viewDidBecomeReady()
}

final class RewardPresenter: RewardPresenting {
    
    /// The front-facing view that conforms to the `RewardDisplay` protocol
    weak var display: RewardDisplay?
    
    // MARK: - RewardPresenting
    
    func viewDidBecomeReady() {
        display?.setTitle(StringKeys.RewardsApp.rewardViewTitle.localized())
        display?.setAnimationContent(fromName: "deer")
    }
}
