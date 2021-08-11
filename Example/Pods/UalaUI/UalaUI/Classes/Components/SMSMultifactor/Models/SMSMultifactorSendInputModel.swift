//
//  SMSMultifactorSendInputModel.swift
//  UalaUI
//
//  Created by Matías Schwalb on 14/07/2021.
//

import Foundation

public struct SMSMultifactorSendInputModel {
    public var email: String?
    public var pinId: String?
    public var phoneNumber: String?
    
    public init(
        email: String? = nil,
        pinId: String? = nil,
        phoneNumber: String? = nil
    ) {
        self.email = email
        self.pinId = pinId
        self.phoneNumber = phoneNumber
    }
}
