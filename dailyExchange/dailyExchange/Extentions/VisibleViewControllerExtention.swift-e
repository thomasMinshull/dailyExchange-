//
//  VisibleViewControllerExtention.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-04-02.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit

extension UIViewController {
    func visibleViewController() -> UIViewController? {
        guard !(self is UINavigationController) else {
            let navVC = self as! UINavigationController
            return navVC.topViewController?.visibleViewController()
        }
        
        guard !(self is UITabBarController) else {
            let tabVC = self as! UITabBarController
            return tabVC.selectedViewController?.visibleViewController()
        }
        
        if self.presentedViewController == nil || self.presentedViewController!.isBeingDismissed {
            return self
        }
        
        return self.presentedViewController?.visibleViewController()
    }
}
