import Foundation
import PromiseKit

public protocol DeviceRepositoryProtocol {
    func getCountryCode() -> Promise<CountryCode>
}

class DeviceRepository: BaseRepository, DeviceRepositoryProtocol {
    func getCountryCode() -> Promise<CountryCode> {
        request(IPRouter())
    }
}
