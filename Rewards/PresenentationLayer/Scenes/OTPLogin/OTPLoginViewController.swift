//
//  OTPLoginViewController.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 23/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit
import RxSwift
import SkyFloatingLabelTextField
import SnapKit

final class OTPLoginViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let inputTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField(
            frame: CGRect.zero)
        return textField
    }()
    
    private let submitButton: UIButton = {
       let button = UIButton(frame: CGRect.zero)
        return button
    }()
    
    
    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    
    /// Keyboard tracking helper
    private let keyboardTracker: KeyboardTracker = KeyboardTracker()
    
    /// Manager to manage tap out to dismiss keyboard feature
    private let tapDismissManager: TapDismissManager = TapDismissManager()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUILayuout()
        
        keyboardTracker.setScrollView(scrollView)
        tapDismissManager.configure(withTargetView: self.view)
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardTracker.registerForNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        keyboardTracker.removeNotifications()
    }
    
    private func configureUILayuout() {
        
        titleLabel.text = "Please Enter your OTP"
        inputTextField.placeholder = "Enter OTP"
        inputTextField.title = "4 digit code"
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.red, for: .normal)
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(inputTextField)
        stackView.addArrangedSubview(submitButton)

        scrollView.addSubview(stackView)
        self.view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(400)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(self.view.snp.width).offset(-100)
            make.centerX.equalTo(self.view.snp.centerX)
        }
    }
}
