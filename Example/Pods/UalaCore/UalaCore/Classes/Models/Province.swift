//
//  Province.swift
//  Uala
//
//  Created by Nelson Domínguez on 01/08/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Province: CustomStringConvertible, Equatable {
    
    public let code: String
    public let name: String
    
    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    
    public var description: String {
        return name
    }
    
    public static func==(lhs: Province, rhs: Province) -> Bool {
        return lhs.code == rhs.code
    }
}

public extension Province {
    
    static func fromLocalBundle() -> [Province] {
        let bundle = BundleUtils.getBundle(from: .Core)
        guard let path = bundle.path(forResource: "provinces", ofType: "json") else { return [] }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let json = try JSON(data: data)
            return ProvinceMapper().map(from: json.arrayValue)
        } catch _ {
            return []
        }
    }
}
