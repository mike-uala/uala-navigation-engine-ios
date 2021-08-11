//
//  PhoneNumberPrefixValidator.swift
//  Uala
//
//  Created by Nelson Domínguez on 09/09/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import Validator

class PhoneNumberPrefixValidationRule: ValidationRule {
    typealias InputType = String
    
    private let phoneNumbersPrefix = PhoneNumbersPrefix()
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        return phoneNumbersPrefix.hasPrefixValid(phoneNumber: input)
    }
}

class PhonePrefixValidationRule: ValidationRule {
    typealias InputType = String
    
    private let phoneNumbersPrefix = PhoneNumbersPrefix()
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        return phoneNumbersPrefix.isValid(prefix: input)
    }
}

class PhoneIsNotUserNumberValidationRule: ValidationRule {
    typealias InputType = String
    
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input, let userNumber = UserSessionData.user?.phoneNumber else { return false }
        return !userNumber.contains(input)
    }
}
