//
//  UIView+MotionEffect.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    /**
     Creates an x and y motion for the view
     
     - parameter amplitude: The amplitude of the motion
     */
    func addMotionEffect(amplitude: CGFloat = 20) {
        let min = -amplitude
        let max = +amplitude
        let xAxis = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xAxis.minimumRelativeValue = min
        xAxis.maximumRelativeValue = max
        
        let yAxis = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yAxis.minimumRelativeValue = min
        yAxis.maximumRelativeValue = max
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xAxis, yAxis]
        
        self.addMotionEffect(group)
    }
}

