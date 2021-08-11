//
//  ConfigurationKey.swift
//  UalaCore
//
//  Created by Laura Krayacich on 03/05/2021.
//

import Foundation

public protocol ConfigurationKeyImpl { }

public struct ConfigurationKey: ConfigurationKeyImpl {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    //MARK: Test
    static let testConfigurationKey = ConfigurationKey(rawValue: "TEST_CONFIG_KEY")

    //MARK: AuthConfig
    static let authConfigDatabase = ConfigurationKey(rawValue: "AUTHCONFIG_DATABASE")
    static let authConfigDomain = ConfigurationKey(rawValue: "AUTHCONFIG_DOMAIN")
    static let authConfigAudience = ConfigurationKey(rawValue: "AUTHCONFIG_AUDIENCE")
    static let authConfigClientId = ConfigurationKey(rawValue: "AUTHCONFIG_CLIENT_ID")

    //MARK: AmazonConfig
    static let amazonUserpoolId = ConfigurationKey(rawValue: "AMAZON_USERPOOL_ID")
    static let amazonClientId = ConfigurationKey(rawValue: "AMAZON_CLIENT_ID")
    static let amazonIdentityPoolId = ConfigurationKey(rawValue: "AMAZON_IDENTITY_POOL_ID")
    static let amazonS3BucketName = ConfigurationKey(rawValue: "S3_BUCKET_NAME")

    static let baseUrlDebit = ConfigurationKey(rawValue: "BASE_URL_DEBIT")
    public static let baseUrlSignUp = ConfigurationKey(rawValue: "BASE_URL_SIGN_UP")
    public static let baseUrlRegistration = ConfigurationKey(rawValue: "BASE_URL_REGISTRATION")

    // MARK: FAQ's
    public static let faqURL = ConfigurationKey(rawValue: "FAQ_URL")
}
