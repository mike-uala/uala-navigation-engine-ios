import Foundation

public protocol Environment {
    var id: String { get }
    var coreAPI: API { get set }
    var amazon: AmazonConfiguration { get set }
    var credentials: Credentials { get }
    var name: String { get set }
    var localeIdentifier: String { get set }
}

public enum CountryEnvironment: String, CaseIterable {
    case Argentina, Mexico, Colombia
}

public struct EnvironmentBuilder {
    
    public static func create(_ scheme: Scheme,
                              _ country: CountryEnvironment = .Argentina) -> Environment {
        
        var environment: Environment
        
        switch country {
        case .Mexico: environment = Mexico()
        case .Argentina: environment = Argentina()
        case .Colombia: environment = Colombia()
        }
        
        environment.amazon.scheme = scheme
        
        return environment
    }
}
