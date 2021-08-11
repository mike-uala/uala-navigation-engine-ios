//
//  WhiteSpaceValidationRule.swift
//  Uala
//
//  Created by Nicolas on 06/06/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import Validator

public class WhiteSpaceValidationRule: ValidationRule {
    
    public typealias InputType = String
    public var error: ValidationError
    
    public init(error: ValidationError) {
        self.error = error
    }
    
    public func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        return !input.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
