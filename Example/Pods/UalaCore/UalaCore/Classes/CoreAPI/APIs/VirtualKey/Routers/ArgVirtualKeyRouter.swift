import Foundation
import Alamofire

struct ArgVirtualKeyRouter: VirtualKeyRouteable {
    var route: VirtualKeyRoute = .getClabeCVU
    
    var path: String {
        switch route {
        case .getClabeCVU, .postClabeCVU:
            return "/2/cvu"
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .getClabeCVU, .postClabeCVU:
            return ArgCVUMapper()
        }
    }
    
    var errorMapper: Mappeable {
        switch route {
        case .getClabeCVU:
            return ArgCVUErrorMapper()
        default:
            return ErrorMapper()
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
