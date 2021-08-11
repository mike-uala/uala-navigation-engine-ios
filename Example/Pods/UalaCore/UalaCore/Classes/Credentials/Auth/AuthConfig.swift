import Foundation

struct AuthConfig {
    var database = String.getConfigurationValue(forKey: .authConfigDatabase)
    var domain = String.getConfigurationValue(forKey: .authConfigDomain)
    var audience = String.getConfigurationValue(forKey: .authConfigAudience)
    var clientId = String.getConfigurationValue(forKey: .authConfigClientId)
}

extension Environment {
    var authConfig: AuthConfig {
        AuthConfig()
    }
}
