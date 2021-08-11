import Foundation

struct FeaturesDTO {
    var menu: [Item]
    var functionalities: [Functionality]?
}

extension FeaturesDTO: Decodable {
    
    struct Item: Decodable {
        var item: String
    }
    
    struct Functionality: Decodable {
        var functionality: String
        enum CodingKeys: String, CodingKey {
            case functionality = "func"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case menu, functionalities
    }
}
