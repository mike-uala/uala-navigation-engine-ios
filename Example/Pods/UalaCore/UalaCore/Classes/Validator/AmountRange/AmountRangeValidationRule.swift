//
//  AmountRangeValidationRule.swift
//  Uala
//
//  Created by Nicolas Wang on 11/01/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import Validator

class AmountMinRangeValidationRule: ValidationRule {
    typealias InputType = String
    
    private let minRange: Int
    var error: ValidationError
    
    init(minRange: Int, error: ValidationError) {
        self.minRange = minRange
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        guard let amount = Float(input) else { return false }
        return amount >= Float(minRange)
    }
}

class AmountMaxRangeValidationRule: ValidationRule {
    typealias InputType = String
    
    private let maxRange: Int
    var error: ValidationError
    
    init(maxRange: Int, error: ValidationError) {
        self.maxRange = maxRange
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        guard let amount = Float(input) else { return false }
        return amount <= Float(maxRange)
    }
}

class AmountEmptyValidationRule: ValidationRule {
    typealias InputType = String
    
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        guard let amount = Float(input) else { return false }
        return amount > 0
    }
}
