//
//  UIFont+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import UIKit

struct FontName {
    static let light = "YOUR-FONT-Light"
    static let regular = "YOUR-FONT-Regular"
    static let semiBold = "YOUR-FONT-Medium"
    static let bold = "YOUR-FONT-Bold"
    static let italic = "YOUR-FONT-Italic"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    @objc class func lightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontName.light, size: size) ??
        UIFont.lightFont(ofSize: size)
    }
    
    @objc class func regularFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontName.regular, size: size) ??
        UIFont.regularFont(ofSize: size)
    }
    
    @objc class func mediumFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontName.semiBold, size: size) ??
               UIFont.mediumFont(ofSize: size)
    }
    
    @objc class func semiBoldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontName.semiBold, size: size) ?? UIFont.semiBoldFont(ofSize: size)
    }
    
    @objc class func boldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontName.bold, size: size) ?? UIFont.boldFont(ofSize: size)
    }
    
    @objc class func italicFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontName.italic, size: size) ?? UIFont.italicFont(ofSize: size)
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        if fontAttribute.lowercased().range(of: "light") != nil {
             fontName = FontName.light
        } else if fontAttribute.lowercased().range(of: "regular") != nil {
            fontName = FontName.regular
        } else if fontAttribute.lowercased().range(of: "medium") != nil {
            fontName = FontName.semiBold
        } else if fontAttribute.lowercased().range(of: "semibold") != nil {
            fontName = FontName.semiBold
        } else if fontAttribute.lowercased().range(of: "bold") != nil {
            fontName = FontName.bold
        } else if fontAttribute.lowercased().range(of: "italic") != nil {
            fontName = FontName.italic
        } else  {
            fontName = FontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self else { return }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(regularFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(boldFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(italicFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
