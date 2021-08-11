//
//  ContainOnlyLettersPattern.swift
//  Uala
//
//  Created by Developer on 7/26/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import Validator

enum UalaValidationPattern: String, ValidationPattern {
    
    case username = "(?!.*[\\.\\-\\_]{2,})^[a-zA-Z0-9\\.\\-\\_]{3,30}$"
    case fullName = "^([A-Za-z\\'\\u00C0-\\u00D6\\u00D8-\\u00f6\\u00f8-\\u00ff\\s]*)$"
    case numbers = "[0-9]*"
    case phoneNumber = "^(?=.{10}$)(\\d{2,4})(\\d{6,8})$"
    case lettersAndNumbers = "^[a-zA-Z0-9\\u00C0-\\u00D6\\u00D8-\\u00f6\\u00f8-\\u00ff\\s]*$"
    case lettersAndNumbersWithWhitespaces = "^[a-zA-Z0-9\\u00C0-\\u00D6\\u00D8-\\u00f6\\u00f8-\\u00ff ]*$"
    case letterNumbersAndHyphens = "^[a-zA-Z0-9\\u00C0-\\u00D6\\u00D8-\\u00f6\\u00f8-\\u00ff\\s-]*$"
    case lettersAndNumbersWithSpecialCharacters = "^[a-zA-Z0-9\\u0021-\\u003F-\\u00A1-\\u00C0-\\u00D6\\u00D8-\\u00f6\\u00f8-\\u00ff ]*$"
    case amount = "^[0-9]+([\\.\\,]{1}[0-9]{1,2})?$"
    case numbersAndScripts = "^([0-9\\-]*)"
    case prefix = "^(\\d{2,4})"

    var pattern: String {
        return self.rawValue
    }
}
