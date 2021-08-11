//
//  EnvironmentHelper.swift
//  UalaUI
//
//  Created by Christian Correa on 17/02/21.
//

import UalaCore

final class EnvironmentHelper {
    var localeIdentifier: String {
        let environment: Environment = ServiceLocator.inject()
        return environment.localeIdentifier
    }
}
