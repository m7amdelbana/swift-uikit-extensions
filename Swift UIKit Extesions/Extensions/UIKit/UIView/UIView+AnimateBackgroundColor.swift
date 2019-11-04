//
//  UIView+AnimateBackgroundColor.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    func animateBackgroundColor(color: UIColor, duration: Double = 0.5) {
        let originalColor = self.backgroundColor?.copy() as? UIColor ?? UIColor.clear
        
        UIView.animate(withDuration: duration) {
            self.backgroundColor = color
            UIView.animate(withDuration: duration) {
                self.backgroundColor = originalColor
            }
        }
    }
}
