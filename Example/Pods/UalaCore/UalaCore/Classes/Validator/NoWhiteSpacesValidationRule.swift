//
//  NoWhiteSpacesValidationRule.swift
//  Alamofire
//
//  Created by Fabrizio Sposetti on 20/02/2020.
//

import Foundation
import Validator


public class NoWhiteSpacesValidationRule: ValidationRule {
    
    public typealias InputType = String
    public var error: ValidationError
    
    public init(error: ValidationError) {
        self.error = error
    }
    
    public func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        return !input.contains(" ")
    }
}
