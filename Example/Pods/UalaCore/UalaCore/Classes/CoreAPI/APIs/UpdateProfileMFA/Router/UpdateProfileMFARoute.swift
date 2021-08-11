//
//  UpdateProfileMFARoute.swift
//  UalaCore
//
//  Created by Ualá on 22/06/21.
//

import Foundation
import Alamofire

public enum UpdateProfileMFARoute {
    case send, resend(String)
}

public protocol UpdateProfileMFARoutable: Routeable {
    var route: UpdateProfileMFARoute { get set }
}

extension UpdateProfileMFARoutable {

    public var method: HTTPMethod {
        .post
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
