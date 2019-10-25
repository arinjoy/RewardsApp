//
//  TapDismissManager.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit

/// Manager to manage tap out to dismiss keyboard function
final class TapDismissManager {
    
    /// the root view to add tap to dismiss feature
    private weak var rootView: UIView?
    
    /// configures tap dismiss manager with target view
    ///
    /// - Parameter view: the root view to add tap to dismiss feature
    func configure(withTargetView view: UIView) {
        rootView = view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        rootView?.endEditing(true)
    }
}
