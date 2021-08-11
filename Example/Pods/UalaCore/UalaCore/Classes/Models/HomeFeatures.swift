import Foundation

public struct HomeFeatures {
    public var items: [HomeType]
    public var functionalities: [Functionalities]
    
    public init(items: [HomeType], functionalities: [Functionalities]) {
        self.items = items
        self.functionalities = functionalities
    }
}

public enum HomeType: String {
    case transfers = "TRANSFERS"
    case account = "ACCOUNT"
    case payment = "PAYMENTS"
    case credits = "CREDITS"
    case portfolio = "PORTFOLIO"
    
    public func getIndex() -> Int {
        switch self {
        case .transfers:
            return 1
        case .account:
            return 2
        case .payment:
            return 3
        case .credits:
            return 4
        case .portfolio:
            return 4
        }
    }
}

public enum Functionalities: String {
    case loans = "loans"
    case installments = "installment_lendings"
}
