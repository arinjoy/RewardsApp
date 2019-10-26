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
import PKHUD
import Lottie

final class OTPLoginViewController: UIViewController {

    // MARK: - View Properties
    
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
    
    private let animatedBackgroundView: AnimationView = {
        let animationView = AnimationView(name: "let-it-snow")
        animationView.animationSpeed = 1.0
        animationView.loopMode = LottieLoopMode.loop
        return animationView
    }()
    
    // MARK: - Private Properties

    /// The presenter conforming to the `OTPLoginPresenting`
    private lazy var presenter: OTPLoginPresenting = {
        let presenter = OTPLoginPresenter(interactor:
            LoginInteractor(
                identityService: IdentityServiceClient(dataSource: HTTPClient())
            )
        )
        presenter.display = self
        presenter.router = OTPLoginRouter(sourceViewController: self)
        return presenter
    }()
    
    /// Keyboard tracking helper
    private let keyboardTracker: KeyboardTracker = KeyboardTracker()
    
    /// Manager to manage tap out to dismiss keyboard feature
    private let tapDismissManager: TapDismissManager = TapDismissManager()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUILayout()
        applyStyle()
        
        keyboardTracker.setScrollView(scrollView)
        tapDismissManager.configure(withTargetView: self.view)
        
        inputTextField.delegate = self
        inputTextField.addTarget(self,
                                 action: #selector(inputTextFieldDidChange),
                                 for: .editingChanged)
        
        submitButton.setImage(Icon.loginSubmitInactive.icon, for: .normal)
        submitButton.isEnabled = false
        submitButton.addTarget(self,
                               action: #selector(submitButtonAction),
                               for: .touchUpInside)
        
        presenter.viewDidBecomeReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardTracker.registerForNotifications()
        
        animatedBackgroundView.play()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        keyboardTracker.removeNotifications()
    }
    
    // MARK: - Private Helpers
    
    private func configureUILayout() {
        
        titleLabel.numberOfLines = 0
        
        submitButton.contentEdgeInsets = .zero
        
        inputTextField.snp.makeConstraints { make in
            make.width.equalTo(170)
            make.height.equalTo(70)
        }
        
        submitButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        
        let inputContainerView = UIView()
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(inputTextField)
        inputContainerView.addSubview(submitButton)
        
        inputTextField.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        submitButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalTo(inputTextField.snp.trailing).offset(5)
        }
        
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        containerStackView.alignment = .center
        containerStackView.spacing = 50
        
        let topPadder = UIView(frame: CGRect.zero)
        topPadder.backgroundColor = .clear
        topPadder.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        
        containerStackView.addArrangedSubview(topPadder)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(inputContainerView)
        
        scrollView.addSubview(animatedBackgroundView)
        animatedBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(containerStackView)
        self.view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
        }

        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(self.view.snp.width).offset(-100)
            make.centerX.equalTo(self.view.snp.centerX)
        }
    }

    private func applyStyle() {
        self.view.backgroundColor = Theme.darkerBackgroundColor
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        titleLabel.textColor = Theme.primaryTextColor
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        inputTextField.keyboardType = .numberPad
        inputTextField.isSecureTextEntry = true
        inputTextField.keyboardAppearance = .dark
        
        inputTextField.lineHeight = 3.0
        inputTextField.selectedLineHeight = 6.0
        
        inputTextField.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        inputTextField.tintColor = Theme.tintColor
        
        inputTextField.textColor = Theme.secondaryTextColor
        inputTextField.lineColor = Theme.primaryTextColor
        inputTextField.selectedTitleColor = Theme.tintColor
        inputTextField.selectedLineColor = Theme.tintColor
        
        inputTextField.errorColor = Theme.errorColor
        inputTextField.lineErrorColor = Theme.errorColor
        inputTextField.textErrorColor = Theme.errorColor
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func submitButtonAction() {
        guard let inputCode = inputTextField.text else { return }
        presenter.didSubmitLogin(withCode: inputCode)
    }
}

// MARK: - OTPLoginDisplay

extension OTPLoginViewController: OTPLoginDisplay {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setCodeInputPlaceholder(_ placeholder: String, andTitle title: String) {
        inputTextField.placeholder = placeholder
        inputTextField.title = title
    }
    
    func showProcessingIndicator(withMessage message: String) {
        HUD.show(.labeledProgress(title: nil, subtitle: message))
    }
    
    func showProcessingIndicatorSuccess() {
        HUD.show(.success)
    }
    
    func showProcessingIndicatorFailure() {
        HUD.show(.error)
    }
    
    func showErrorMessage(_ message: String) {
        HUD.hide(afterDelay: 1.0) { _ in
            HUD.flash(.label(message), delay: 1.5)
        }
    }
    
    func hideProcessingIndicator(afterDelay delay: TimeInterval) {
        HUD.hide(afterDelay: delay)
    }
    
    func showCodeInputError(message: String?) {
        inputTextField.errorMessage = message
    }
    
    func hideCodeInputError() {
        inputTextField.errorMessage = nil
    }
    
    func enableSubmitButton(_ enabled: Bool) {
        let buttonImage = enabled ?
            Icon.loginSubmitActive.icon : Icon.loginSubmitInactive.icon
        submitButton.setImage(buttonImage, for: .normal)
        submitButton.isEnabled = enabled
    }
}

extension OTPLoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String
    ) -> Bool {
        guard textField == inputTextField,
            let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 4
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField == inputTextField else { return }
        presenter.codeInputDidEnterTyping()
    }
    
    @objc private func inputTextFieldDidChange(textField: UITextField) {
        guard textField == inputTextField else { return }
        presenter.codeInputDidEnterText(textField.text)
    }
}


