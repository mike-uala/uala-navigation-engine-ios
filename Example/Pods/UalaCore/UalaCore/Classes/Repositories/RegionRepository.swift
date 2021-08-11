import Foundation
import PromiseKit

public typealias Composed = (localities: [AddressItem], provinces: [AddressItem])
public protocol RegionRepositoryProtocol {
    func getProvinces() -> Promise<[AddressItem]>
    func getZipCodes(withLocalityId id: Int) -> Promise<[AddressItem]>
    func getLocalities(withProvinceID id: Int) -> Promise<[AddressItem]>
    func getProvinces(withZipCode zipCode: String) -> Promise<Composed>
}

class RegionRepository: BaseRepository, RegionRepositoryProtocol {
    func getProvinces() -> Promise<[AddressItem]> {
        return requestAuth(coreAPI.placesAPI(route: .provinceA))
    }
    
    func getZipCodes(withLocalityId id: Int) -> Promise<[AddressItem]> {
        return requestAuth(coreAPI.placesAPI(route: .zipCodeA(id)))
    }
    
    func getLocalities(withProvinceID id: Int) -> Promise<[AddressItem]> {
        return requestAuth(coreAPI.placesAPI(route: .localityA(id)))
    }
    
    func getProvinces(withZipCode zipCode: String) -> Promise<Composed> {
        return requestAuth(coreAPI.placesAPI(route: .provinceAndLocality(zipCode)))
    }
}
