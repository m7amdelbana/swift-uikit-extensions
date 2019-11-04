//
//  DesignableView.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class RoundedView: UIView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
    }
}

@IBDesignable class DesignableView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkFrame()
    }
    
    func checkFrame() {
        if let layers = layer.sublayers, let gLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is CAGradientLayer
        }) {
            gLayer.frame = bounds
        }
        
        if let layers = layer.sublayers, let bLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is BottomLayer
        }) {
            bLayer.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        }
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if newValue >= 0 {
                layer.cornerRadius = newValue
                clipsToBounds = newValue > 0
            }
        }
    }
    
   
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            if newValue >= 0 {
                layer.borderWidth = newValue
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            } else {
                return .clear
            }
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var bottomBorder: UIColor {
        get {
            return getBottomBorderColor()
        }
        set {
            bottomBorderLayer.backgroundColor = newValue.cgColor
        }
    }
    
    @IBInspectable var topBorder: UIColor {
        get {
            return getTopBorderColor()
        }
        set {
            topBorderLayer.backgroundColor = newValue.cgColor
        }
    }
    
    var bottomBorderLayer: BottomLayer {
        if let layers = layer.sublayers, let border = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is BottomLayer
        }) {
            return border as! BottomLayer
        } else {
            checkObserver()
            let border = BottomLayer()
            border.superView = self
            border.frame = CGRect(x: 0, y: bounds.height - 1.7, width: bounds.width, height: 1.7)
            layer.addSublayer(border)
            
            return border
        }
    }
    var topBorderLayer: TopLayer {
        if let layers = layer.sublayers, let border = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is TopLayer
        }) {
            return border as! TopLayer
        } else {
            checkObserver()
            let border = TopLayer()
            border.superView = self
            border.frame = CGRect(x: 0, y: 0 ,width: bounds.width, height: 1)
            layer.addSublayer(border)
            
            return border
        }
    }
    
    func getTopBorderColor() -> UIColor {
        if let color = topBorderLayer.backgroundColor {
            return UIColor(cgColor: color)
        } else {
            return .clear
        }
    }
    
    func getBottomBorderColor() -> UIColor {
        if let color = bottomBorderLayer.backgroundColor {
            return UIColor(cgColor: color)
        } else {
            return .clear
        }
    }
    
    @IBInspectable var startColor: UIColor {
        get {
            return getColor()
        }
        set {
            setColor(newValue, 0)
        }
    }
    
    @IBInspectable var endColor: UIColor {
        get {
            return getColor()
        }
        set {
            setColor(newValue, 1)
        }
    }
    
    var gradientLayer: GradientLayer {
        if let layers = layer.sublayers, let gLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is GradientLayer
        }) {
            return gLayer as! GradientLayer
        } else {
            checkObserver()
            let gLayer = GradientLayer()
            gLayer.superView = self
            gLayer.frame = bounds
            layer.insertSublayer(gLayer, at: 0)
            
            return gLayer
        }
    }
    
    func getColor() -> UIColor {
        if let color = gradientLayer.colors?.last as? UIColor {
            return color
        } else {
            return .clear
        }
    }
    
    func setColor(_ color: UIColor, _ index: Int) {
        gradientLayer.colors![index] = color.cgColor
    }
    
    func checkObserver() {
        addObserver(self, forKeyPath: "bounds", options: .init(rawValue: 0), context: nil)
    }
    
    func updateBounds() {
        if let layers = layer.sublayers, let gLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is CAGradientLayer
        }) {
            gLayer.frame = bounds
        }
        
        if let layers = layer.sublayers, let bLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is BottomLayer
        }) {
            bLayer.frame = CGRect(x: 0, y: bounds.height - 1.7, width: bounds.width, height: 1.7)
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let view = object as? UIView, view == self, keyPath == "bounds" {
            updateBounds()
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setShadowAndCornerRadiusToView(view: UIView, isCornerRadius: Bool, isShadow: Bool, radius: Int ) {
        setShadowFrame(2)
        
        if isShadow {
            view.layer.shadowColor = UIColor(red: 0/255.0 , green: 0/255.0, blue: 0/255.0, alpha: 0.16).cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
            view.layer.shadowRadius = 2
            view.layer.shadowOpacity = 1
        }
        
        if isCornerRadius {
            view.layer.cornerRadius = CGFloat(radius)
        }
        
        view.layer.masksToBounds = false
    }
    
    func setShadowToView(view: UIView) {
        setShadowFrame(2)
        view.layer.shadowColor = UIColor(red: 0/255.0 , green: 0/255.0, blue: 0/255.0, alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
    }
    
    func setShadowFrame(_ sSize: CGFloat) {
        let newFrame = CGRect(x: -sSize / 2, y: -sSize / 2, width: frame.size.width + sSize, height: frame.size.height + sSize)
        let sPath = ShadowPath(roundedRect: newFrame, cornerRadius: layer.cornerRadius)
        sPath.superView = self
        layer.shadowPath = sPath.cgPath
    }
    
    func circularView(view: UIView) {
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
    }
}

@IBDesignable extension UIView {
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
}

class GradientLayer: CAGradientLayer {
    
    var superView: UIView!
    var isObserving = false
    
    override init() {
        super.init()
        
        let clear = UIColor.clear.cgColor
        startPoint = CGPoint(x: 1, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
        locations = [0.05, 0.95]
        colors = [clear, clear]
        
        isObserving = false
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if isObserving {
            isObserving = false
            superView.removeObserver(superView, forKeyPath: "bounds")
        }
    }
}

class BottomLayer: CALayer {
    
    var superView: UIView!
    var isObserving = false
    
    override init() {
        super.init()
        
        isObserving = true
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if isObserving {
            isObserving = false
            superView.removeObserver(superView, forKeyPath: "bounds")
        }
    }
}

class TopLayer: CALayer {
    
    var superView: UIView!
    var isObserving = false
    
    override init() {
        super.init()
        
        isObserving = true
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if isObserving {
            isObserving = false
            superView.removeObserver(superView, forKeyPath: "bounds")
        }
    }
}

class ShadowPath: UIBezierPath {
    var superView: UIView!
    var isObserving = false
    
    override init() {
        super.init()
        isObserving = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if isObserving {
            isObserving = false
        }
    }
}

