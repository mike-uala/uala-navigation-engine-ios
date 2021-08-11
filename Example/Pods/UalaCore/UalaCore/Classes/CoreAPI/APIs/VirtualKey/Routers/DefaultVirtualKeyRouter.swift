//
//  DefaultVirtualKeyRouter.swift
//  UalaCore
//
//  Created by Federico Frias on 19/05/2021.
//

import Foundation
import Alamofire

struct DefaultVirtualKeyRouter: VirtualKeyRouteable {
    var route: VirtualKeyRoute = .getClabeCVU
    
    var path: String {
        switch route {
        case .getClabeCVU:
            return "/1/users/products"
        case .postClabeCVU:
            return ""
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .getClabeCVU, .postClabeCVU:
            return DefaultAccountMapper()
        }
    }
    
    var method: HTTPMethod {
        switch route {
        case .getClabeCVU:
            return .get
        case .postClabeCVU:
            return .post
        }
    }
}

