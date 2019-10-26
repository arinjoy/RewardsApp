//
//  Theme+Icon.swift
//  Rewards
//
//  Created by Arinjoy Biswas on 25/10/19.
//  Copyright © 2019 Arinjoy Biswas. All rights reserved.
//

import UIKit

enum Icon: String {
    
    case loginSubmitActive = "login-icon"
    case loginSubmitInactive = "login-inactive-icon"
    
    var icon: UIImage {
        guard let image = UIImage(named: self.rawValue)
            else {
                fatalError("Image resource \(self.rawValue) cannot be loaded")
        }
        return image.withRenderingMode(.alwaysOriginal)
    }
}
