import Foundation
import Alamofire

struct VirtualKeyRouter: VirtualKeyRouteable {
    var route: VirtualKeyRoute = .getClabeCVU
    
    var path: String {
        switch route {
        case .getClabeCVU:
            return "/1/spei/clabe"
        case .postClabeCVU:
            return ""
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .getClabeCVU, .postClabeCVU:
            return MexClabeMapper()
        }
    }
    
    var method: HTTPMethod {
        switch route {
        case .getClabeCVU:
            return .get
        case .postClabeCVU:
            return .post
        }
    }
}
