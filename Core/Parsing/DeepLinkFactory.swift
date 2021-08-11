//
//  DeepLinkFactory.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation
import CoreLocation

public class DeepLinkFactory {
    
    let scheme: String
    let host: String
    
    public init(scheme: String, host: String) {
        self.scheme = scheme
        self.host = host
    }
}

extension DeepLinkFactory {
    
    public func homeURL() -> DeepLink {
        let endpoint = Endpoint(scheme: scheme,
                                host: host,
                                path: "/home",
                                queryItems: nil)
        return endpoint.url
    }
    
    public func loginURL() -> DeepLink {
        let endpoint = Endpoint(scheme: scheme,
                                host: host,
                                path: "/login",
                                queryItems: nil)
        return endpoint.url
    }
    
    public func updatePasswordURL(token: ResetPasswordToken) -> DeepLink {
        let tokenQueryItem = URLQueryItem(name: "resetToken", value: token)
        let endpoint = Endpoint(scheme: scheme,
                                host: host,
                                path: "/resetPassword",
                                queryItems: [tokenQueryItem])
        return endpoint.url
    }
}

extension DeepLinkFactory {
    
}

extension DeepLinkFactory {

}

