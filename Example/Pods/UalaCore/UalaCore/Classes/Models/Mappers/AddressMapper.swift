import Foundation
import SwiftyJSON

class AddressMapper {
    
    private static let provincies = Province.fromLocalBundle()
    
    static func map(from json: JSON) -> Address {
        
        let environment: Environment = ServiceLocator.inject()
        return (environment as! AddressMapperDependenciesProtocol).map(from: json)
    }
}
