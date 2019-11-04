//
//  CALayout+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

extension CALayer {
    
    func shadow(color: UIColor = .black, opacity: Float = 1.0, radius: CGFloat = 1.0, offset: CGSize = .zero) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = opacity
        self.shadowRadius = radius
        self.shadowOffset = offset
    }
    
    func roundedCorner(radius: CGFloat? = nil) {
        var cornerRadius = CGFloat(roundf(Float(self.frame.size.width / 2.0)))
        if let r = radius {
            cornerRadius = r
        }
        
        self.masksToBounds = true
        self.cornerRadius = cornerRadius
    }
    
    func border(color: UIColor = .black, width: CGFloat) {
        self.borderColor = color.cgColor
        self.borderWidth = width
    }
}
