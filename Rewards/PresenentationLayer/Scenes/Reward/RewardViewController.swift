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
    
    /// Main Reward view - Deer, or something else as as your Reward
    private let animationRewardView: AnimationView = {
        let animationView = AnimationView()
        animationView.animationSpeed = 0.8
        animationView.loopMode = LottieLoopMode.loop
        return animationView
    }()
    
    /// Decorative background view
    private let animatedBackgroundView: AnimationView = {
        let animationView = AnimationView(name: "let-it-snow")
        animationView.animationSpeed = 1.0
        animationView.loopMode = LottieLoopMode.loop
        animationView.play()
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
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = Theme.darkerBackgroundColor
        
        configureLayout()

        presenter.viewDidBecomeReady()
        
        animationRewardView.play()
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
        
        self.view.addSubview(animatedBackgroundView)
        self.view.addSubview(animationRewardView)
        
        animatedBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        animationRewardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
