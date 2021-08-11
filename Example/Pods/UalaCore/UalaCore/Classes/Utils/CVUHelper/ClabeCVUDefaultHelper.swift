//
//  ClabeCVUDefaultHelper.swift
//  UalaCore
//
//  Created by Federico Frias on 19/05/2021.
//

import Foundation
import PromiseKit

class ClabeCVUDefaultHelper: ClabeCVUHelperProtocol {
    let accountRepo: AccountRepositoryProtocol = ServiceLocator.inject()
    
    func setupClabeCVU() -> Promise<Void> {
        return Promise<Void> { seal in
            guard UserSessionData.virtualKey == nil else {
                seal.fulfill_()
                return
            }
            accountRepo.getClabeCVU().done { account in
                UserSessionData.virtualKey = account
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
