//
//  UpdateProfileSendMFA.swift
//  UalaCore
//
//  Created by Ualá on 22/06/21.
//

import Foundation

public class UpdateProfileSendMFA {
    
    public var pinId: String
    public var smsStatus: String
    public var phoneNumber: String

    public init(
        pinId: String,
        smsStatus: String,
        phoneNumber: String
    ) {
        self.pinId = pinId
        self.smsStatus = smsStatus
        self.phoneNumber = phoneNumber
    }
}
