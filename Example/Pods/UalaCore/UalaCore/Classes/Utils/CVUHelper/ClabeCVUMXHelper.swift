import Foundation
import PromiseKit

class ClabeCVUMXHelper: ClabeCVUHelperProtocol {
    let accountRepo: AccountRepositoryProtocol = ServiceLocator.inject()
    
    func setupClabeCVU() -> Promise<Void> {
        return Promise<Void> { seal in
            guard UserSessionData.virtualKey == nil else {
                seal.fulfill_()
                return
            }
            accountRepo.getClabeCVU().done { cvu in
                UserSessionData.virtualKey = cvu
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
