//
//  ChatStatusMapper.swift
//  UalaTransactions
//
//  Created by Enzo Digiano on 02/03/2021.
//

import Foundation

class ChatStatusMapper {
    
    static func map(from DTOModel: ChatStatusDTO) -> ChatStatus? {
        let chatStatus = ChatStatus()
        chatStatus.message = DTOModel.message
        chatStatus.status = DTOModel.status
        return chatStatus
    }
}
