//
//  BankMapper.swift
//  Uala
//
//  Created by Hasael Oliveros on 8/11/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

public class BankMapper {
    
    func map(from json: [JSON]) -> [Bank] {
        return json.map { map(from: $0) }
    }
    
    func map(from json: JSON) -> Bank {
        return Bank(
            code: json["code"].stringValue,
            name: json["bank"].stringValue
        )
    }
}

