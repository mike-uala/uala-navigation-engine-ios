//
//  CountryMapper.swift
//  Uala
//
//  Created by Nelson Domínguez on 25/08/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

class CountryMapper {
    
    private static func flag(code: String) -> String {
        let base: UInt32 = 127397
        return code.unicodeScalars.flatMap { String.init(UnicodeScalar(base + $0.value)!) }.joined()
    }
    
    private static func name(code: String) -> String {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: NSLocale.current.identifier).displayName(forKey: NSLocale.Key.identifier, value: id) ?? code
    }
    
    static func map(from json: JSON) -> Country {
        
        let cca2 = json["cca2"].stringValue
        let ccn3 = json["ccn3"].stringValue
        
        let code = ccn3
        let name = CountryMapper.name(code: cca2)
        let flag = CountryMapper.flag(code: cca2)
        
        return Country(code: code, name: name, flag: flag)
    }
}
