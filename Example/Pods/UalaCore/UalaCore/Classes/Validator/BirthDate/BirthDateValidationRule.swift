//
//  BirthDateValidationRule.swift
//  Uala
//
//  Created by Nicolas on 13/03/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import Validator

class BirthDateValidationRule: ValidationRule {
        
    private let minAge: Int
    typealias InputType = Date
    var error: ValidationError
    
    init(error: ValidationError, minAge: Int) {
        self.error = error
        self.minAge = minAge
    }
    
    func validate(input: Date?) -> Bool {
        guard let input = input else { return false }
        return input.age >= minAge && input.age <= 99
    }
}
