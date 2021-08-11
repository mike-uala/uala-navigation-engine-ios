//
//  CountryItem.swift
//  Uala
//
//  Created by Nelson Domínguez on 25/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

open class Country: CustomStringConvertible, Equatable {
    
    // Argentina
    public static let `default` = "032"
    
    // ISO 3166-1 numeric code
    public let code: String
    
    // Localized name
    public var name: String
    
    // Emoji flag
    public let flag: String
    
    public init(code: String, name: String, flag: String) {
        self.code = code
        self.name = name
        self.flag = flag
    }
    
    open var description: String {
        return "\(flag) \(name)"
    }
    
    public static func==(lhs: Country, rhs: Country) -> Bool {
        return lhs.code == rhs.code
    }
}
