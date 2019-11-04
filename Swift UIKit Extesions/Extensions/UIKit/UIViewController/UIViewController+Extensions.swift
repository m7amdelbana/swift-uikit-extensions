//
//  UIViewController+Extensions.swift
//  Swift UIKit Extesions
//
//  Created by Mohamed Elbana on 11/4/19.
//  Copyright © 2019 Mohamed Elbana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
     Adds a view controller as a child
     
     - parameter viewController: The view controller
     - parameter toView:         The view to add the view controller's view (default: self.view)
     */
    public func addChild(viewController: UIViewController, toView: UIView? = nil) {
        let view: UIView = toView ?? self.view
        self.addChild(viewController)
        viewController.willMove(toParent: self)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    /**
     Removes a view controller from the hierarchy
     */
    public func removeFromParentViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
