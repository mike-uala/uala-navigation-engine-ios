import Foundation
import PromiseKit
import Alamofire

public class ProfileRepository {
            
    private var baseAPIManager: BaseApiManager {
        return ServiceLocator.inject()
    }

    public init() { }
    
    public func details() -> Promise<User> {
        let environment: Environment = ServiceLocator.inject()
        return (environment as! ProfileRepositoyDependenciesProtocol).details()
    }
    
    public func balance() -> Promise<Balance> {
        return Promise<Balance> { seal in
            baseAPIManager.requestApi1(path: "balance", method: .get).done{ result in
                let balance = BalanceMapper.map(from: result["balance"])
                UserSessionData.balance = balance
                seal.fulfill(balance)
                }.catch({ error in
                    seal.reject(error)
                })
        }
    }
    
    public func verify(securityCode: String) -> Promise<Bool> {
        return Promise<Bool> { seal in
            let parameters = ["pin" : securityCode]            
            baseAPIManager.requestApi1(path: "accounts/pin/validate",
                                       method: .post,
                                       parameters: parameters,
                                       encoding: JSONEncoding.default).done{ result in
                                        seal.fulfill(result["valid"].boolValue)
                }.catch({ error in
                    seal.reject(error)
                })
        }
        
    }
}
