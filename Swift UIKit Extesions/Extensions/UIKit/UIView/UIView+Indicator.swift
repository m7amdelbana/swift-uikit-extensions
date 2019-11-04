//
//  UIView+Indicator.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addIndicator(_ style: UIActivityIndicatorView.Style) {
        removeIndicator()
        let indicator = UIActivityIndicatorView(style: style)
        var frame = indicator.frame
        frame.size = self.frame.size
        indicator.frame = frame
        indicator.tag = 1
        indicator.startAnimating()
        self.addSubview(indicator)
    }
    
    func removeIndicator() {
        for subView in self.subviews {
            if let indicator = subView as? UIActivityIndicatorView, indicator.tag == 1 {
                indicator.removeFromSuperview()
            }
        }
    }
}

