//
//  UIApplication.swift
//  Uala
//
//  Created by Nicolas on 22/12/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

extension UIApplication {
    public func open(url: URL) {
        self.open(url, options: [:], completionHandler: nil)
    }
    
    public class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
