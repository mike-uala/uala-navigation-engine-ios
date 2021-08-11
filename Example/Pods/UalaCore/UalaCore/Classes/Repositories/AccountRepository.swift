import Foundation
import PromiseKit

public protocol AccountRepositoryProtocol {
    func currentAccount() -> Promise<Account>
    func updateAccount() -> Promise<Void>
    func getHomeTabs() -> Promise<HomeFeatures>
    func getClabeCVU() -> Promise<VirtualKey>
    func postCVU() -> Promise<VirtualKey>
    func updateUserEmail(email: String,
                     pin: String,
                     mfaPin: String,
                     mfaPinId: String) -> Promise<Void>
}

public class AccountRepository: BaseRepository, AccountRepositoryProtocol {
    
    public func currentAccount() -> Promise<Account> {
        return requestAuth(coreAPI.accountAPI(route: .account))
    }

    public func updateAccount() -> Promise<Void> {
        return requestAuth(coreAPI.accountAPI(route: .updateAccount))
    }

    public func getHomeTabs() -> Promise<HomeFeatures> {
        return requestAuth(coreAPI.accountAPI(route: .features))
    }
    
    public func getClabeCVU() -> Promise<VirtualKey> {
        return requestAuth(coreAPI.virtualKeyAPI(route: .getClabeCVU))
    }
    
    public func postCVU() -> Promise<VirtualKey> {
        return requestAuth(coreAPI.virtualKeyAPI(route: .postClabeCVU))
    }
    
    public func updateUserEmail(
        email: String,
        pin: String,
        mfaPin: String,
        mfaPinId: String
    ) -> Promise<Void> {
        return requestAuth(coreAPI.accountAPI(route: .updateUserEmail(email, pin, mfaPin, mfaPinId)))
    }
}
