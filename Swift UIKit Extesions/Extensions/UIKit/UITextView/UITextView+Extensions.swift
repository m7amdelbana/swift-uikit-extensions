//
//  UITextView+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DesignableTextView: UITextView, UITextViewDelegate {
    
    var placeholderLabel: UILabel!
    
    func addLabel() {
        delegate = self
        
        let labelFrame = CGRect(x: textContainer.lineFragmentPadding, y: textContainerInset.top, width: frame.width, height: 20)
        placeholderLabel = UILabel(frame: labelFrame)
        placeholderLabel.font = font
        placeholderLabel.text = "Write..."
        placeholderLabel.textColor = .lightGray
        addSubview(placeholderLabel)
        
        addObserver(self, forKeyPath: "text", options: [], context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "text")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelFrame = CGRect(x: textContainer.lineFragmentPadding, y: textContainerInset.top, width: frame.width, height: 20)
        placeholderLabel.frame = labelFrame
    }
    
    @IBInspectable var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            if placeholderLabel == nil {
                addLabel()
            }
            
            placeholderLabel.text = newValue
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            textChanged()
        }
    }
    
    func textChanged() {
        if text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
}
