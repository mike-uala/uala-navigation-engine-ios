import UalaCore
import Alamofire

public enum TransactionsRoute {
    case transactions(String?)
}

public protocol TransactionsRouteable: Routeable {
    var route: TransactionsRoute { get set }
}

extension TransactionsRouteable {
    
    var method: HTTPMethod {
        .get
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: Parameters? {
        switch route {
        case .transactions(let type):
            guard let type = type else { return nil }
            return ["type" : type]
        }
    }
}
