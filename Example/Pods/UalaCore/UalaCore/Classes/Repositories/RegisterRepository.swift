import Alamofire
import PromiseKit

public struct UpdateAddressRequest {
    public var address: Address
    public var deliveryAddress: Address
    
    public init(address: Address, deliveryAddress: Address) {
        self.address = address
        self.deliveryAddress = deliveryAddress
    }
}

public class RegisterRepository {
    let APIManager: BaseApiManager = ServiceLocator.inject()
    
    public init() {}
    
    public func editAddress(request: UpdateAddressRequest) -> Promise<Void> {
        
        guard let homeAddress = request.address.jsonString(),
            let deliveryAddress = request.deliveryAddress.jsonString()
            else { return Promise(error: UalaError.addressRequired) }
        
        let formattedHomeAddress = homeAddress.replacingOccurrences(of: "\"", with: "\\\"")
        let formattedDeliveryAddress = deliveryAddress.replacingOccurrences(of: "\"", with: "\\\"")
        
        let parameters: Parameters = ["address" : formattedHomeAddress, "deliveryAddress" : formattedDeliveryAddress]
        
        return Promise<Void> { seal in
            APIManager.requestApi2(path: "users", method: .put,parameters: parameters,encoding: JSONEncoding.default).done({ (json) in
                seal.fulfill_()
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
}
