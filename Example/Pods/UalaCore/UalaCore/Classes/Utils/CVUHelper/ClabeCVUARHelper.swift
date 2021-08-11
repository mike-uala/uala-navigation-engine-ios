import Foundation
import PromiseKit

class ClabeCVUARHelper: ClabeCVUHelperProtocol {
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
                guard let ualaError = error as? UalaError else {
                    return
                }
                switch ualaError {
                case .cvuWithoutAlias, .cvuDoesntExist:
                    self.postCVU().done {
                        seal.fulfill_()
                        }.catch { error in
                            seal.reject(error)
                    }
                default: seal.reject(error)
                }
            }
        }
    }
    
    private func postCVU() -> Promise<Void> {
        return Promise<Void> { seal in
            accountRepo.postCVU().done { cvu in
                UserSessionData.virtualKey = cvu
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
}
