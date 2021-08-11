//
//  SplitConfiguration.swift
//  Uala
//
//  Created by Josefina Perez on 13/02/2020.
//  Copyright © 2020 Ualá. All rights reserved.
//

import Foundation
import Split

public protocol SplitConfigurationProtocol {
    var apiKey: String { get set }
}

public struct SplitConfiguration {
   
    public var apiKey: String {
        
        switch ApplicationConfiguration.current() {
        case .develop:
            return "jk3u7gkubb0nl919b9m18puqtu7fe3n7mcgp"
        case .test:
            return "6fpdnqce8hct3l3j9t5fhpr1a4a1uaej7c1t"
        case .stage:
            return "1l0fj1qesmacia911rt25mar36u6c8kln0hg"
        case.production:
            return "dgmqbfjjl1e1iv2d7kbs31gotqd91lug80n8"
        }
    }
    
    /// Only used when is initialized from demo
    /// - Parameter scheme: `Scheme` object
    /// - Returns: `String` key
    public func demoApiKey(from scheme: Scheme) -> String {
        switch scheme {
            case .develop:
                return "jk3u7gkubb0nl919b9m18puqtu7fe3n7mcgp"
            case .test:
                return "6fpdnqce8hct3l3j9t5fhpr1a4a1uaej7c1t"
            case .stage:
                return "1l0fj1qesmacia911rt25mar36u6c8kln0hg"
            case.production:
                return "dgmqbfjjl1e1iv2d7kbs31gotqd91lug80n8"
        }
    }
}
