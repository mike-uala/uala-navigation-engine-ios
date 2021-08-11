//
//  UIFont.swift
//  Uala
//
//  Created by Developer on 7/14/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public extension UIFont {
    
    class func regular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
    
    class func bold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
    }
    
    class func semiBold(size: CGFloat) -> UIFont {
        return  UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
    }
    
    class func light(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
    }

}
