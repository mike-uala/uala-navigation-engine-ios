import Foundation
import Alamofire

public enum RegionRoute {
    case provinceA,
    localityA(Int),
    zipCodeA(Int),
    provinceAndLocality(String)
}

public protocol RegionsRouteable: Routeable {
    var route: RegionRoute { get set }
}

extension RegionsRouteable {
        
    public var path: String {
        switch route {
        case .provinceA:
            return "/provinces"
        case .localityA(let id):
            return "/provinces/\(id)/localities"
        case .zipCodeA(let id):
            return "/localities/\(id)/zip_codes"
        case .provinceAndLocality(let zipCode):
            return "/zip_codes/\(zipCode)"
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var parameters: Parameters? {
        return nil
    }
    
    public var mapper: Mappeable {
        switch route {
        case .provinceA:
            return ProvinceMap()
        case .localityA(_):
            return LocalityMap()
        case .zipCodeA(_):
            return ZipCodeMap()
        case .provinceAndLocality(_):
            return ComposedProvinceMap()
        }
    }
    
    var baseUrl: String {
        switch scheme() {
        case .stage:
            return "https://7vezdf13f5.execute-api.us-east-1.amazonaws.com/stage/places"
        case .test:
            return "https://9bt4f5o390.execute-api.us-east-1.amazonaws.com/test/places"
        case .develop:
            return "https://8doxkzaxcb.execute-api.us-east-1.amazonaws.com/dev/places"
        case .production:
            return "https://j7striby73.execute-api.us-east-1.amazonaws.com/prod/places"
        }
    }
}

struct RegionRouter: RegionsRouteable {
    var route: RegionRoute = .provinceA
}
