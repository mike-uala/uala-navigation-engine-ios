//
//  Currency.swift
//  Uala
//
//  Created by Nicolas on 23/05/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Currencies {
    public var alphabeticCode: String
    var currency: String
    var entity: String
    var minorUnit: String
    public var numericCode: String
    
    init(
        alphabeticCode: String,
        currency: String,
        entity: String,
        minorUnit: String,
        numericCode: String
        ) {
        self.alphabeticCode = alphabeticCode
        self.currency = currency
        self.entity = entity
        self.minorUnit = minorUnit
        self.numericCode = numericCode
    }
}

public class CurrenciesMapper {
    public static func map(from json: JSON) -> Currencies {
        let alphabeticCode = json["AlphabeticCode"].stringValue
        let currency = json["Currency"].stringValue
        let entity = json["Entity"].stringValue
        let minorUnit = json["MinorUnit"].stringValue
        let numericCode = json["NumericCode"].stringValue
        
        return Currencies(alphabeticCode: alphabeticCode, currency: currency, entity: entity, minorUnit: minorUnit, numericCode: numericCode)
    }
}
