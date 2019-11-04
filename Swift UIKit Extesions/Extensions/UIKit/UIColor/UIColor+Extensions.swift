//
//  UIColor+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let primary = UIColor(hex: 0x000000)
    static let accent = UIColor(hex: 0xFFFFF)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0,green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(red: (hex >> 16) & 0xFF, green: (hex >> 8) & 0xFF, blue: hex & 0xFF, a: a)
    }
    
    func brightness(_ percent: CGFloat, lighter: Bool) -> UIColor {
        let v = self.hsba
        var newBrightness = max(v.b * percent, 0.0)
        if lighter {
            newBrightness = min(v.b * percent, 1.0)
        }
        return UIColor(hue: v.h, saturation: v.s, brightness: newBrightness, alpha: v.a)
    }
    
    func lighterColor(percent: CGFloat = 1.25) -> UIColor {
        return self.brightness(percent, lighter: true)
    }
    
    func darkerColor(percent: CGFloat = 0.75) -> UIColor {
        return self.brightness(percent, lighter: false)
    }
    
    public var isDarkColor: Bool {
        return self.lumens < 0.5
    }
    
    public var isBlackOrWhite: Bool {
        let v = self.rgba
        
        if v.r > 0.91 && v.g > 0.91 && v.b > 0.91 {
            return true
        }
        
        if v.r < 0.09 && v.g < 0.09 && v.b < 0.09 {
            return true
        }
        
        return false
    }
    
    public func set(alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
    public func set(hue: CGFloat) -> UIColor {
        let v = self.hsba
        
        return UIColor(hue: hue, saturation: v.s, brightness: v.b, alpha: v.a)
    }
    
    public func set(saturation: CGFloat) -> UIColor {
        let v = self.hsba
        
        return UIColor(hue: v.h, saturation: saturation, brightness: v.b, alpha: v.a)
    }
    
    public func set(brightness: CGFloat) -> UIColor {
        let v = self.hsba
        return UIColor(hue: v.h, saturation: v.s, brightness: brightness, alpha: v.a)
    }
    
    public func isDistinct(color: UIColor, threshold: CGFloat = 0.25) -> Bool {
        let rgba1 = self.rgba
        let rgba2 = color.rgba
        
        if  abs(rgba1.r - rgba2.r) > threshold ||
            abs(rgba1.g - rgba2.g) > threshold ||
            abs(rgba1.b - rgba2.b) > threshold ||
            abs(rgba1.a - rgba2.a) > threshold {
            if  abs(rgba1.r - rgba1.g) < 0.03 &&
                abs(rgba1.r - rgba1.b) < 0.03 &&
                abs(rgba2.r - rgba2.g) < 0.03 &&
                abs(rgba2.r - rgba2.b) < 0.03 {
                return false
            }
            return true
        }
        return false
    }
    
    public func isContrasting(color: UIColor) -> Bool {
        let bLum = self.lumens
        let fLum = color.lumens
        
        var contrast: CGFloat = 0.0
        
        if bLum > fLum {
            contrast = (bLum + 0.05) / (fLum + 0.05)
        }
        else {
            contrast = (fLum + 0.05) / (bLum + 0.05)
        }
        return contrast > 1.6
    }
    
    private var rgbColorSpace: UIColor {
        let c = self.cgColor.components!
        let a = self.cgColor.alpha
        
        return UIColor(red: c[0], green: c[1], blue: c[2], alpha: a)
    }
    
    public var rgba: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let convertedColor = self.rgbColorSpace
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        convertedColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r:r, g:g, b:b, a:a)
    }
    
    public var ryba: (r: CGFloat, y: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.rgba
        var r = components.r
        var g = components.g
        var b = components.b
        
        let whiteness = min(r, min(g, b))
        r -= whiteness
        g -= whiteness
        b -= whiteness
        
        let mg = max(r, max(g, b))
        
        var y = min(r, g)
        r -= y
        g -= y
        
        if b > 0 && g > 0 {
            b /= 2.0
            g /= 2.0
        }
        
        y += g
        b += g
        
        let my = max(r, max(y, b))
        if my > 0 {
            let n = mg / my
            r *= n
            y *= n
            b *= n
        }
        
        r += whiteness
        y += whiteness
        b += whiteness
        
        return (r: r, y: y, b: b, a: components.a)
    }
    
    public var cmyka: (c: CGFloat, m: CGFloat, y: CGFloat, k: CGFloat, a: CGFloat) {
        var c: CGFloat = 0
        var y: CGFloat = 0
        var m: CGFloat = 0
        var k: CGFloat = 0
        
        let components = self.rgba
        let r = components.r
        let g = components.g
        let b = components.b
        
        k = min(1.0 - r, min(1.0 - g, 1.0 - b))
        if k < 1.0 {
            c = (1.0 - r - k) / (1.0 - k)
            m = (1.0 - g - k) / (1.0 - k)
            y = (1.0 - b - k) / (1.0 - k)
        }
        
        return (c: c, m: m, y: y, k: k, a: components.a)
    }
    
    public var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h:h, s:s, b:b, a:a)
    }
    
    public var lumens: CGFloat {
        let v = self.rgba
        let lum = 0.212_6 * v.r + 0.715_2 * v.g + 0.072_2 * v.b
        return lum
    }
    
    public var rgbaColor: UIColor {
        let alpha = self.cgColor.alpha
        
        let opaqueColor = self.cgColor.copy(alpha: 1.0)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let components = rgbColorSpace.numberOfComponents
        let rgba = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: components)
        let bitmapInfo = CGImageAlphaInfo.noneSkipLast.rawValue
        let ref = CGContext(data: nil,
                            width: 1,
                            height: 1,
                            bitsPerComponent: 8,
                            bytesPerRow: 4,
                            space: rgbColorSpace,
                            bitmapInfo: bitmapInfo)!
        
        ref.setFillColor(opaqueColor!)
        ref.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        
        let r = CGFloat(rgba[0]) / 255.0
        let g = CGFloat(rgba[0]) / 255.0
        let b = CGFloat(rgba[0]) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    public var rgbColor: UIColor {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorSpaceModel = colorSpace.model
        let cgColor = self.cgColor
        let cgColorSpace = cgColor.colorSpace
        
        if cgColorSpace?.model.rawValue == colorSpaceModel.rawValue {
            return self
        }
        
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
