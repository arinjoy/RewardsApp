//
//  File.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit

enum Theme {
    
    // MARK: - Colors
    
    static let tintColor = UIColor.colorFrom(red: 71, green: 158, blue: 104) // light teal
    
    static let backgroundColor = UIColor.white
    
    static let darkerBackgroundColor = UIColor.colorFrom(red: 226, green: 232, blue: 230) // light tealish gray
    
    static let primaryTextColor = UIColor.darkText
    
    static let secondaryTextColor = UIColor.darkGray
    
    static let errorColor = UIColor.colorFrom(red: 165, green: 69, blue: 69) // Grayish red
}

private extension UIColor {
    static func colorFrom(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}

