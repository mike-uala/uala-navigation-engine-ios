//
//  UpdateProfileMFARepository.swift
//  UalaCore
//
//  Created by Ualá on 22/06/21.
//

import Foundation
import PromiseKit

public protocol UpdateProfileMFARepositoryProtocol {
    func sendProfileMFA() -> Promise<UpdateProfileSendMFA>
    func resendProfileMFA(pinId: String) -> Promise<UpdateProfileSendMFA>
}

class UpdateProfileMFARepository: BaseRepository, UpdateProfileMFARepositoryProtocol {
    
    func sendProfileMFA() -> Promise<UpdateProfileSendMFA> {
        return requestAuth(coreAPI.updateProfileMFAAPI(route: .send))
    }
    
    func resendProfileMFA(pinId: String) -> Promise<UpdateProfileSendMFA> {
        return requestAuth(coreAPI.updateProfileMFAAPI(route: .resend(pinId)))
    }
}
