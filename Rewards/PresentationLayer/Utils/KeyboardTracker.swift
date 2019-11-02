//
//  KeyboardTracker.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit

final class KeyboardTracker {
    
    // MARK: - Private Properties
    
    private var scrollView: UIScrollView!
    

    // MARK: - Available features
    
    var keyboardInsetPadding: CGFloat = 20
    
    func setScrollView(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Private Functions
    
    @objc private func keyboardWillShow(notification: Notification) {
        updateScrollViewInsets(with: keyboardBounds(from: notification), keyboardInsetPadding: keyboardInsetPadding)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        updateScrollViewInsets(with: keyboardBounds(from: notification), keyboardInsetPadding: 0)
    }
    
    private func keyboardBounds(from notification: Notification) -> CGRect {
        return notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    }
    
    private func updateScrollViewInsets(with keyboardBounds: CGRect, keyboardInsetPadding: CGFloat) {
        var keyboardInsetHeight: CGFloat = 0
        if let height = scrollView.superview?.bounds.size.height {
            keyboardInsetHeight = height - scrollView.frame.origin.y - scrollView.frame.size.height
        }
        
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let keyboardOnscreenHeight: CGFloat = screenHeight - keyboardBounds.origin.y
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: max(0, keyboardOnscreenHeight - keyboardInsetHeight + keyboardInsetPadding), right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset

    }
}
