//
//  RewardViewController.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 26/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

final class RewardViewController: UIViewController, RewardDisplay {

    // MARK: - View Properties
    
    private let animationRewardView: AnimationView = {
        let animationView = AnimationView()
        animationView.animationSpeed = 1.0
        animationView.loopMode = LottieLoopMode.loop
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    // MARK: - Private Properties
    
    /// The presenter conforming to the `RewardPresenting`
    private lazy var presenter: RewardPresenting = {
        let presenter = RewardPresenter()
        presenter.display = self
        return presenter
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        configureLayout()
        
        presenter.viewDidBecomeReady()
    }
    
    // MARK: - RewardDisplay
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setAnimationContent(fromName name: String) {
        animationRewardView.animation = Animation.named(name)
    }
    
    // MARK: - Private Helpers
    
    func configureLayout() {
        
        self.view.addSubview(animationRewardView)
        
        animationRewardView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
