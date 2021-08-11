import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit
import Auth0

public class BaseApiManager {
    
    private var environment: Environment {
        return ServiceLocator.inject()
    }
    
    private var credentials: Credentials {
        return environment.credentials
    }
    
    private var baseUrl: String {
        return environment.amazon.endPoint
    }
    
    @available(*, deprecated, message: "use Routeable instead")
    public func requestApi1(path: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, tokenRequired: Bool = true) -> Promise<JSON> {
        return request(path: "/1/" + path, method: method, parameters: parameters, encoding: encoding, tokenRequired: tokenRequired)
    }
    
    @available(*, deprecated, message: "use Routeable instead")
    public func requestApi2(path: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default) -> Promise<JSON> {
        return request(path: "/2/" + path, method: method, parameters: parameters, encoding: encoding)
    }
    
    @available(*, deprecated, message: "use Routeable instead")
    public func requestApi3(path: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default) -> Promise<JSON> {
        return request(path: "/3/" + path, method: method, parameters: parameters, encoding: encoding)
    }
    
    @available(*, deprecated, message: "use Routeable instead")
    func request(path: String, method: HTTPMethod, parameters: Parameters?,
                 encoding: ParameterEncoding = URLEncoding.default, tokenRequired: Bool = true) -> Promise<JSON> {
        var headerParameters = ["Content-Type": "application/json",
                                "Accept": "application/json"]
        
        if tokenRequired {
            return credentials.getToken().then { token -> Promise<JSON> in
                headerParameters["Authorization"] = token
                return self.request(url: self.baseUrl + path, method: method, parameters: parameters, encoding: encoding, headers: HTTPHeaders(headerParameters))
            }
        } else {
              return self.request(url: self.baseUrl + path, method: method, parameters: parameters, encoding: encoding, headers: HTTPHeaders(headerParameters))
        }
    }
    
    private func request(url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders?) -> Promise<JSON> {
        return Promise { seal in
            AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let result):
                        seal.fulfill(JSON(result))
                        
                    case .failure(let error):
                        if let data = response.data,
                            let error: UalaError = ErrorMapper().map(data) {
                            seal.reject(error)
                            return
                        }
                        
                        seal.reject(error)
                    }
                }
        }
    }
    
    public func requestAuth<T>(_ router: Routeable) -> Promise<T> {
        return credentials.getToken().then { token -> Promise<T> in
            return self.request(router, token: token)
        }
    }
    
    public func requestAuth<T>(_ router: Routeable, body: [String: String]) -> Promise<T> {
        return credentials.getToken().then { token -> Promise<T> in
            return self.request(router, token: token, body: body)
        }
    }
    
    public func requestAuth0UserProfile<T: Decodable>(mapper: T.Type) -> Promise<T> {
        return credentials.getUserInfo(mapper: mapper)
    }
    
    public func request<T>(_ router: Routeable, token: String? = nil, body: [String: String]? = nil) -> Promise<T> {
        guard var request = try? router.asURLRequest(token: token) else {
            return Promise.init(error: UalaError.undefined)
        }
        
        if let body = body {
            do {
                let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                request.httpBody = jsonBody
            } catch {
                return Promise.init(error: UalaError.undefined)
            }
        }
        
        return Promise { seal in
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else { return }
                        if let result: T = router.mapper.map(data) {
                            seal.fulfill(result)
                        } else {
                            seal.reject(UalaError.undefined)
                        }
                    case .failure(let error):
                        if let data = response.data,
                            let error: UalaError = router.errorMapper.map(data) {
                            seal.reject(error)
                            return
                        }
                        seal.reject(error)
                    }
            }
        }
    }
}
