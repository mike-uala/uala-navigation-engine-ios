//
//  ChatStatusMapeable.swift
//  UalaTransactions
//
//  Created by Enzo Digiano on 02/03/2021.
//

import Foundation
import UalaCore

struct SalesforceChatStatusMapper: MappeableType {
    
    typealias Result = ChatStatusDTO
    
    func map<T>(_ data: Data) -> T? {
        return SalesforceChatStatusBuilder.salesforceChatStatus(dto: decode(data)) as? T
    }
}

struct SalesforceChatStatusBuilder {
    
    static func salesforceChatStatus(dto: ChatStatusDTO?) -> ChatStatus? {
        guard let dto = dto else { return nil }
        return ChatStatusMapper.map(from: dto)
    }
}


