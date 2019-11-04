//
//  UILabel+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setText(text: String, withLineSpacing lineSpacing: CGFloat = 1.0) {
        self.text = nil
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: string.length))
        self.attributedText = string
    }
    
    /**
     Calculates the height of the label for a given width, font, and text
     
     - parameter width: The width to fit in
     - parameter font:  The font used to display the text
     - parameter text:  The text to display
     
     - returns: The height needed to display
     */
    public class func height(forWidth width: CGFloat, font: UIFont, text: String) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let label = UILabel(frame: CGRect(origin: .zero, size: size))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}

