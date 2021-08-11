import Foundation
import SwiftyJSON

public class UserMapper {
    
    public static func map(from json: JSON) -> User {
        let environment: Environment = ServiceLocator.inject()
        return (environment as! UserMapperDependenciesProtocol).map(from: json)
    }
}
