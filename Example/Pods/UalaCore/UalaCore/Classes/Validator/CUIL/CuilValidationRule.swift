//
//  CuilValidationRule.swift
//  Uala
//
//  Created by Nelson Domínguez on 26/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import Validator

class CuilValidationRule: ValidationRule {
    
    private let cuil = CUIL()
    private var prefix: String
    
    typealias InputType = String
    var error: ValidationError
    
    init(prefix: String, error: ValidationError) {
        self.prefix = prefix
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        return cuil.isValid(cuil: input)
    }
}
