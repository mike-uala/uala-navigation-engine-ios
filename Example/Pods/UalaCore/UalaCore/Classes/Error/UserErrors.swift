import Foundation

enum CBUError: String, Error {
    case invalidCbu = "3000"
    case virtual = "7"
    case inactive = "6"
    case currency = "8"
    case unknown
    
    var description: String {
        switch self {
        case .invalidCbu: return translate("INVALID_CBU_ERROR")
        case .virtual: return translate("BANK_CBU_ERROR")
        case .inactive: return translate("INACTIVE_CBU_ERROR")
        case .currency: return translate("CURRENCY_CBU_ERROR")
        default: return translate("INVALID_CBU_ERROR")
        }
    }
}

