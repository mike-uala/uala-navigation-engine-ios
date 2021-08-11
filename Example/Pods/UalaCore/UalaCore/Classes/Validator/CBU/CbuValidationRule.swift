//
//  CbuValidationRule.swift
//  Uala
//
//  Created by Hasael Oliveros on 8/11/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import Validator

class CbuValidationRule: ValidationRule {
    
    private let cbu = CBU()
    
    typealias InputType = String
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        return cbu.isValid(cbuNumber: input)
    }
}
