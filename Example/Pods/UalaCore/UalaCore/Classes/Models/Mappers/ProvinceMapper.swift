//
//  ProvinceMapper.swift
//  Uala
//
//  Created by Nelson Domínguez on 01/08/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProvinceMapper {
    
    func map(from json: [JSON]) -> [Province] {
        return json.map { map(from: $0) }
    }
    
    func map(from json: JSON) -> Province {
        return Province(
            code: json["id"].stringValue,
            name: json["nombre"].stringValue
        )
    }
}

