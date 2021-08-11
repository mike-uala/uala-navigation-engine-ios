//
//  UpdateProfileMFABuilder.swift
//  UalaCore
//
//  Created by Ualá on 22/06/21.
//

import Foundation

struct UpdateProfileMFABuilder {
    
    static func mfaIdentifier(dto: UpdateProfileMFADTO?) -> UpdateProfileSendMFA? {
        guard let dto = dto else { return nil }

        return UpdateProfileSendMFA(
            pinId: dto.pinId,
            smsStatus: dto.smsStatus,
            phoneNumber: dto.phoneNumber
        )
    }
}
