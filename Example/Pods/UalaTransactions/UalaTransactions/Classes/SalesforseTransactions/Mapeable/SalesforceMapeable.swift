//
//  SalesforceMapeable.swift
//  UalaTransactions
//
//  Created by Enzo Digiano on 06/11/2020.
//

import Foundation
import UalaCore

struct SalesforceMapper: MappeableType {
    
    typealias Result = ClaimDTO
    
    func map<T>(_ data: Data) -> T? {
        return SalesforceBuilder.salesforceTransaction(dto: decode(data)) as? T
    }
}

struct SalesforceBuilder {
    
    static func salesforceTransaction(dto: ClaimDTO?) -> Claim? {
        guard let dto = dto else { return nil }
        return ClaimMapper.map(from: dto)
    }
}
