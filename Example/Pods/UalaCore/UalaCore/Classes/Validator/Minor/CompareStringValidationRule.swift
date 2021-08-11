//
//  CompareStringValidationRule.swift
//  Uala
//
//  Created by Nicolas Wang on 19/06/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import Validator

class CompareStringValidationRule: ValidationRule {
    
    typealias InputType = String
    var error: ValidationError
    var fatherEmail: String
    
    init(fatherEmail: String, error: ValidationError) {
        self.fatherEmail = fatherEmail
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        return input != fatherEmail
    }
}
