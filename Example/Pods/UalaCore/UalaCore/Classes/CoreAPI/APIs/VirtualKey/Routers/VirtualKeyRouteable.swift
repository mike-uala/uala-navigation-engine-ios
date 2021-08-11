import Foundation
import Alamofire

public enum VirtualKeyRoute {
    case getClabeCVU, postClabeCVU
}

public protocol VirtualKeyRouteable: Routeable {
    var route: VirtualKeyRoute { get set }
}

extension VirtualKeyRouteable {
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: Parameters? {
        return nil
    }
}
