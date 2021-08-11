import Foundation

public enum CountryCode: String {
    case AR, MX, CO
    
    public var environment: CountryEnvironment {
        switch self {
        case .AR:
            return .Argentina
        case .MX:
            return .Mexico
        case .CO:
            return .Colombia
        }
    }
}
