//
//  Configuration.swift
//  UalaCore
//
//  Created by Juan Camilo Navarro Alvira on 31/03/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import Foundation
import PromiseKit

class Configuration {
    static let shared = Configuration()

    private static var scheme: String {
        let environment: Environment = ServiceLocator.inject()
        guard let scheme = Scheme(rawValue: environment.amazon.scheme.rawValue) else { return "" }
        return scheme.rawValue.capitalized
    }

    private func getConfigurationPath(from bundle: StringTables) -> String {
        let environment: Environment = ServiceLocator.inject()
        let country = CountryEnvironment(rawValue: environment.name) ?? .Argentina
        return bundle.rawValue + "\(country)" + "Configuration"
    }

    func getConfigurationValue<T>(withType _: T.Type, key: ConfigurationKey, from bundle: StringTables?) -> T? {
        if let configurations = self.getConfigurationDict(from: bundle) {
            return configurations.object(forKey: key.rawValue) as? T
        }
        return nil
    }

    func getConfigurationConstant<T>(withType _: T.Type, key: ConfigurationConstantsKey, from bundle: StringTables? = .Core) -> T? {
        guard let constants = self.getConfigurationDict("Constants", from: bundle) else { return nil }
        return constants.object(forKey: key.rawValue) as? T
    }

    private func getConfigurationDict(_ scheme: String = scheme, from bundle: StringTables? = .Core) -> NSDictionary? {
        let path = self.getConfigurationPath(from: bundle!)
        let envsPListPath = BundleUtils.getBundle(from: bundle).path(forResource: path, ofType: "plist")
        guard let data = try? NSData(contentsOfFile: envsPListPath ?? "") as Data else { return nil }
        do {
            if let enviroments = try PropertyListSerialization.propertyList(from: data,
                                                                            options: .mutableContainersAndLeaves,
                                                                            format: nil) as? [String: Any] {
                return enviroments[scheme] as? NSDictionary
            }
        } catch { print(error.localizedDescription) }
        return nil
    }
}

public extension String {
    static func getConfigurationValue(forKey key: ConfigurationKey, from bundle: StringTables? = .Core) -> String {
        return Configuration.shared.getConfigurationValue(withType: String.self, key: key, from: bundle) ?? ""
    }

    static func getConfigurationConstant(forKey key: ConfigurationConstantsKey, from bundle: StringTables? = .Core) -> String {
        return Configuration.shared.getConfigurationConstant(withType: String.self, key: key, from: bundle) ?? ""
    }
}

public extension Int {
    static func getConfigurationValue(forKey key: ConfigurationKey, from bundle: StringTables? = .Core) -> Int {
        return Configuration.shared.getConfigurationValue(withType: Int.self, key: key, from: bundle) ?? 0
    }

    static func getConfigurationConstant(forKey key: ConfigurationConstantsKey, from bundle: StringTables? = .Core) -> Int {
        return Configuration.shared.getConfigurationConstant(withType: Int.self, key: key, from: bundle) ?? 0
    }
}

public extension Double {
    static func getConfigurationValue(forKey key: ConfigurationKey, from bundle: StringTables? = .Core) -> Double {
        return Configuration.shared.getConfigurationValue(withType: Double.self, key: key, from: bundle) ?? 0.0
    }

    static func getConfigurationConstant(forKey key: ConfigurationConstantsKey, from bundle: StringTables? = .Core) -> Double {
        return Configuration.shared.getConfigurationConstant(withType: Double.self, key: key, from: bundle) ?? 0.0
    }
}
