//
//  FeatureFlaggingServiceLocator.swift
//  Uala
//
//  Created by Josefina Perez on 17/02/2020.
//  Copyright © 2020 Ualá. All rights reserved.
//

import Foundation
import UalaCore

public class FeatureFlaggingServiceLocator: ServiceLocatorModule {
    
    public init() {}
    
    public func registerServices(serviceLocator: ServiceLocator) {
        serviceLocator.register { self.provideFeatureFlaggingManager() }
    }

    private func provideFeatureFlaggingManager() -> FeatureFlaggingManager {
        return FeatureFlaggingManager.shared
    }
}
