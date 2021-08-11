import Foundation
import Alamofire

public enum AccountRoute {
    case account, features, updateAccount, createPin, updateUserEmail(String, String, String, String)
}

public protocol AccountRouteable: Routeable {
    var route: AccountRoute { get set }
}

extension AccountRouteable {
    
    var method: HTTPMethod {
        .get
    }
    
    var encoding: ParameterEncoding {
        switch route {
        case .updateUserEmail:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch route {
        case .updateUserEmail(let email, let pin, let mfaPin, let mfaPinId):
            return ["email" : email,
                    "pin": pin,
                    "mfaPin": mfaPin,
                    "mfaPinId": mfaPinId]
        default:
            return nil
        }
    }
}
