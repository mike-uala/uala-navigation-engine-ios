import Alamofire

struct IPRouter: Routeable {
    private let key = "4a987aec2b96c994d8b155ac9822a3eda0ca05e771ce0f3c084e7edc"
        
    let path = String()
    let method: HTTPMethod = .get
    let mapper: Mappeable = IPMapper()
    let baseUrl = "https://api.ipdata.co"
    var parameters: Parameters? { ["api-key" : key] }
    let encoding: ParameterEncoding = URLEncoding.default
}
