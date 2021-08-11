//
//  SMSMultifactorVerifyInputModel.swift
//  UalaUI
//
//  Created by Matías Schwalb on 14/07/2021.
//

import Foundation

public struct SMSMultifactorVerifyInputModel {
    public var pinId: String?
    public var pin: String?
    public var newEmail: String?
    public var userPin: String?
    public var year: String?
    public var month: String?
    // Beneficiary Data
    public var beneficiaryName: String?
    public var beneficiaryLastName: String?
    public var beneficiaryEmail: String?
    public var beneficiaryBirth: String?
    public var percentage: Int?
    
    public init(
        pinId: String? = nil,
        pin: String? = nil,
        newEmail: String? = nil,
        userPin: String? = nil,
        year: String? = nil,
        month: String? = nil,
        beneficiaryName: String? = nil,
        beneficiaryLastName: String? = nil,
        beneficiaryEmail: String? = nil,
        beneficiaryBirth: String? = nil,
        percentage: Int? = 0
    ) {
        self.pinId = pinId
        self.pin = pin
        self.newEmail = newEmail
        self.userPin = userPin
        self.year = year
        self.month = month
        self.beneficiaryName = beneficiaryName
        self.beneficiaryLastName = beneficiaryLastName
        self.beneficiaryEmail = beneficiaryEmail
        self.beneficiaryBirth = beneficiaryBirth
        self.percentage = percentage
    }
}
