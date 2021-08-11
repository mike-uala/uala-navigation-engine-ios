import Foundation
import Alamofire

public protocol BaseURL {
    var baseUrl: String { get }
}

public protocol Routeable: BaseURL {
    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters? { get }
    var mapper: Mappeable { get }
    var errorMapper: Mappeable { get }
    var headers: HTTPHeaders? { get }
}

extension Routeable {
                
    func asURLRequest(token: String?) throws -> URLRequest {
            
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
                
        if let token = token {
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        }
        
        if let headers = headers {
            for (field, value) in headers.dictionary {
                urlRequest.setValue(value, forHTTPHeaderField: field)
            }
        }
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    public var baseUrl: String {
        let environment: Environment = ServiceLocator.inject()
        return environment.amazon.endPoint
    }
    
    public func scheme() -> Scheme {
        let environment: Environment = ServiceLocator.inject()
        return environment.amazon.scheme
    }
    
    public var errorMapper: Mappeable {
        ErrorMapper()
    }
    
    public var headers: HTTPHeaders? {
        [:]
    }
}
