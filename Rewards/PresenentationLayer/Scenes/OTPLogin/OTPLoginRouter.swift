//
//  OTPLoginRouter.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit

protocol OTPLoginRouting: class {
    
    /// Will route to the `Reward` scene
    func routeToRewardScene()
}

final class OTPLoginRouter: OTPLoginRouting {
    
    weak var sourceViewController: UIViewController?
    
    init(sourceViewController: UIViewController?) {
        self.sourceViewController = sourceViewController
    }

    func routeToRewardScene() {
        
        sourceViewController?.navigationController?.pushViewController(
            RewardViewController(),
            animated: true)
    }
}
