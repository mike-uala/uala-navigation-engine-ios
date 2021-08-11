//
//  AccountMapper.swift
//  UalaCore
//
//  Created by Federico Frias on 10/05/2021.
//

import Foundation

struct AccountMapper: MappeableType {
    
    typealias Result = responseUserDTO
    func map<T>(_ data: Data) -> T? {
        return AccountBuilder.account(dto: decode(data)) as? T
    }
}
