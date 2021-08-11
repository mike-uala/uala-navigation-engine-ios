import Foundation
import PromiseKit
import Auth0

open class BaseRepository {
 
    private let base: BaseApiManager = ServiceLocator.inject()
    var coreAPI: API {
        get {
            let environment: Environment = ServiceLocator.inject()
            return environment.coreAPI
        }
        set { }
    }
    
    public init() {}
    
    public func requestAuth<T>(_ router: Routeable) -> Promise<T> {
        return base.requestAuth(router)
    }
    public func request<T>(_ router: Routeable) -> Promise<T> {
        return base.request(router)
    }
    public func requestAuth0UserProfile<T: Decodable>(mapper: T.Type) -> Promise<T> {
        return base.requestAuth0UserProfile(mapper: mapper)
    }
}
