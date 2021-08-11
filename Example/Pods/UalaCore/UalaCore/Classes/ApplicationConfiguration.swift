//
//  ApplicationConfiguration.swift
//  Uala
//
//  Created by Nelson Domínguez on 13/09/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

enum ApplicationConfiguration: String, Equatable {

    case develop
    case test
    case stage
    case production

    public init(safeRawValue: String) {
        self = ApplicationConfiguration(rawValue: safeRawValue) ?? .develop
    }

    static func current() -> ApplicationConfiguration {
        return ApplicationConfiguration(safeRawValue: Bundle.main.appConfiguration)
    }

    public static func==(lhs: ApplicationConfiguration, rhs: ApplicationConfiguration) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    static var versionURL: String {
        switch self.current() {
        case .production: return "https://h3wx5ejua1.execute-api.us-east-1.amazonaws.com/prod/mobile/ios/settings"
        default: return "https://h3wx5ejua1.execute-api.us-east-1.amazonaws.com/test/mobile/ios/settings"
        }
    }
    
    static var pushPlatform: String {
        switch self.current() {
        case .production: return "APNS"
        default: return "APNS_SANDBOX"
        }
    }
    
    static var buildVersion: String {
        switch self.current() {
        case .production: return "prod_min_version"
        default: return "test_min_version"
        }
    }
    
    static var minAge: String {
        switch self.current() {
        case .production: return "prod_min_age"
        default: return "test_min_age"
        }
    }
    
    static var availability: String {
        switch self.current() {
        case .production: return "prod_service_available"
        default: return "test_service_available"
        }
    }
    
    static var enviroment: String {
        switch self.current() {
        case .production: return "PROD"
        case .develop: return "DEV"
        case .test: return "TEST"
        case .stage: return "STAGE"
        }
    }
}

extension Bundle {

    fileprivate enum Keys: String {
        case appConfiguration = "AppConfiguration"
    }

    fileprivate func value<T>(for key: String) -> T? {
        return infoDictionary?[key] as? T
    }

    fileprivate var appConfiguration: String {
        if let configuration: String = value(for: Keys.appConfiguration.rawValue) {
            return configuration
        }
        fatalError("Could not get the configuration")
    }
}

extension Bundle {
    
    fileprivate var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    fileprivate var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

