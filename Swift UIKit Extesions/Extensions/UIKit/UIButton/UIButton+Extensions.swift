//
//  UIButton+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var imageViewContentType: Int {
        get {
            return imageView?.contentMode.rawValue ?? 0
        }
        set {
            if let content = UIView.ContentMode(rawValue: newValue), imageView != nil {
                imageView!.contentMode =  content
            }
        }
    }
    
    func setBorder(borderColor: UIColor) {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
    }
    
    func setShadow() {
        self.backgroundColor = .black
        self.layer.shadowColor = UIColor(red: 152/255.0 , green: 107/255.0, blue: 72/255.0, alpha: 0.47).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
    }
    
    func underLine(title: String) {
        let attrs = [NSAttributedString.Key.font : self.titleLabel!.font!,
                     NSAttributedString.Key.foregroundColor : self.titleColor(for: .normal)!,
                     NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string: "")
        let buttonTitleStr = NSMutableAttributedString(string: title, attributes:attrs)
        attributedString.append(buttonTitleStr)
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
