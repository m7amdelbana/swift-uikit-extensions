//
//  UISearchBar+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    @IBInspectable var background: UIImage? {
        get {
            return backgroundImage
        }
        set {
            if newValue == nil {
                backgroundImage = UIImage()
            } else {
                backgroundImage = newValue
            }
        }
    }
}
