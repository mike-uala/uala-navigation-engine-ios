//
//  SubeValidationRule.swift
//  Uala
//
//  Created by Nicolas on 05/12/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import Validator

class SubeValidationRule: ValidationRule {
    
    typealias InputType = String
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        return validate(subeCardNumber: input)
    }
    
    private func validate(subeCardNumber: String) -> Bool {
        guard let lastSubeNumber = Int(subeCardNumber[subeCardNumber.count-1]) else { return false }
        guard String(subeCardNumber.prefix(6)) == "606126" else { return false }
        
        let cardIdentifier = subeCardNumber.chopSuffix()
        
        var sum = 0
        var alternate = true
        
        for index in (0..<cardIdentifier.count).reversed() {
            guard var lastNumber = Int(cardIdentifier[index]) else { return false }
            if alternate {
                lastNumber *= 2
                if lastNumber > 9 {
                    let lastNumberString = "\(lastNumber)"
                    guard let firstNumber = Int(lastNumberString[0]), let secondNumber = Int(lastNumberString[1]) else { return false }
                    lastNumber = firstNumber+secondNumber
                }
            }
            sum += lastNumber
            alternate = !alternate
        }
        let doubleString = "\(Double(sum)/10.0)"
        guard let lastDoubleString = Int(doubleString[doubleString.count-1]) else { return false }
        var identifier = 10-lastDoubleString
        identifier = identifier == 10 ? 0 : identifier
        return identifier == lastSubeNumber
    }
 }
