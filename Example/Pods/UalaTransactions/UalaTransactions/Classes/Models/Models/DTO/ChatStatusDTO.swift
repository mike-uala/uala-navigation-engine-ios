//
//  ChatStatusDTO.swift
//  UalaTransactions
//
//  Created by Enzo Digiano on 02/03/2021.
//

import Foundation

struct ChatStatusDTO: Codable {
    var message: String?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case status
    }
}
