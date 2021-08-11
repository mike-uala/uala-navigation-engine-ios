//
//  TravelsNoticeDateValidationRule.swift
//  Uala
//
//  Created by Nicolas on 21/02/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import Validator

class TravelsNoticeDateValidationRule: ValidationRule {
    
    typealias InputType = TravelsNotice
    
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: TravelsNotice?) -> Bool {
        guard let input = input else { return false }
        return input.isDateValid()
    }
}

class TravelsNoticeEmptyCountryValidationRule: ValidationRule {
    
    typealias InputType = TravelsNotice
    
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: TravelsNotice?) -> Bool {
        guard let input = input else { return false }
        return input.isCountryNotEmpty()
    }
}

class TravelsNoticeCountryValidationRule: ValidationRule {
    
    typealias InputType = TravelsNotice
    
    var error: ValidationError
    
    init(error: ValidationError) {
        self.error = error
    }
    
    func validate(input: TravelsNotice?) -> Bool {
        guard let input = input else { return false }
        return input.isCountryValid()
    }
}

extension TravelsNotice {
    func isDateValid() -> Bool {
        return self.dateFrom < self.dateTo
    }
    
    func isCountryValid() -> Bool {
        
        guard let countries = self.countries else { return false }
        let countryArray = countries.components(separatedBy: ",")
        return countryArray.count <= 5
    }
    
    func isCountryNotEmpty() -> Bool {
        guard let countries = self.countries else { return false }
        let countryArray = countries.components(separatedBy: ",")
        return !countryArray.isEmpty
    }
}
