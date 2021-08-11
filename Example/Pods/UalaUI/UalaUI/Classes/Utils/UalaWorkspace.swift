//
//  UalaWorkspace.swift
//  UalaUI
//
//  Created by Christian Correa on 03/03/21.
//

import UIKit

public class UalaWorkspace {
    
    public class var mainScreenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    public class var mainScreenWidth: CGFloat {
        return UalaWorkspace.mainScreenSize.width
    }
    
    public class var mainScreenHeight: CGFloat {
        return UalaWorkspace.mainScreenSize.height
    }
    
    public class func isIphoneX() -> Bool {
        return UalaWorkspace.isIphone() && UIScreen.main.bounds.size.height == 812.0
    }
    
    public class func isIphoneXOrBigger() -> Bool {
        return UalaWorkspace.isIphone() && UIScreen.main.bounds.size.height >= 812.0
    }
    
    public class func isIphone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public class func isIphone5() -> Bool {
        return isIphone() && mainScreenHeight == 568.0
    }
}
