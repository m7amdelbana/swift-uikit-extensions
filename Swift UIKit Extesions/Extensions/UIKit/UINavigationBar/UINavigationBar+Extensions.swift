//
//  UINavigationBar+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    @IBInspectable var background: UIImage? {
        get {
            return backgroundImage(for: .default)
        }
        set {
            if newValue == nil {
                setBackgroundImage(UIImage(), for: .default)
            } else {
                setBackgroundImage(newValue, for: .default)
            }
            
            shadowImage = UIImage()
        }
    }
}
