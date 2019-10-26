//
//  RewardDisplay.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

protocol RewardDisplay: class {
    
    /// Will set the view title in navigation bar
    ///
    /// - Parameter title: The title to set
    func setTitle(_ title: String)
    
    /// Will set the Reward related animation content
    ///
    /// - Parameter name: The name of the lottie file
    func setAnimationContent(fromName name: String)
}
