//
//  CoreEnvironment.swift
//  UalaCore
//
//  Created by Christian Correa on 23/07/21.
//

import Foundation

public class CoreEnvironment  {

    public static var shared: CoreEnvironment!
    public var environment: Environment

    private init(environment: Environment) {
        self.environment = environment
        CoreEnvironment.shared = self
    }

    @discardableResult
    static func shared(environment: Environment) -> CoreEnvironment {
        switch shared {
        case let i?:
            i.environment = environment
            return i
        default:
            shared = CoreEnvironment(environment: environment)
            return shared
        }
    }
}
