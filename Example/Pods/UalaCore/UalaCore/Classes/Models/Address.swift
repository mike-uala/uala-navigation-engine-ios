//
//  Address.swift
//  Uala
//
//  Created by Nelson Domínguez on 28/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Address {
    
   public var province: Province?
   public var locality: String?
   public var street: String?
   public var number: String?
   public var floor: String?
   public var department: String?
   public var observations: String?
   public var zipCode: String?
   public var hasStreetNumber: Bool?
    
    public init() { }
}

public extension Address {
    
    func jsonString() -> String? {
        
        let province = self.province?.code
        
        let dictionaryAddress = [
            "P": province.safeString,
            "L": locality.safeString,
            "S": street.safeString,
            "N": number.safeString,
            "F": floor.safeString,
            "A": department.safeString,
            "O": observations.safeString,
            "Z": zipCode.safeString
        ]
        
        return JSON(dictionaryAddress).rawString([
            .jsonSerialization: JSONSerialization.WritingOptions(rawValue: 0)
        ])
    }
}
