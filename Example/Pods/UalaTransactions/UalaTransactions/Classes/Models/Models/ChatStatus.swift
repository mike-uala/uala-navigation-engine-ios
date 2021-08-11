//
//  ChatStatus.swift
//  UalaTransactions
//
//  Created by Enzo Digiano on 02/03/2021.
//

import Foundation
import UalaCore

public class ChatStatus: Codable {
    public var message: String?
    public var status: String?
    var type: ChatStatusType?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
    }
    
    public func getType() -> ChatStatusType {
        guard let statusString = self.status  else { return .unavailable }
        return ChatStatusType.parse(rawValue: statusString)
    }
}

public enum ChatStatusType {
    case available
    case unavailable
    case highDemand
    case unknown(UalaError)
    
    static func parse(rawValue:String) -> ChatStatusType {
        switch rawValue {
            case "AVAILABLE" : return .available
            case "UNAVAILABLE" : return .unavailable
            case "HIGH_DEMAND" : return .highDemand
            default: return unknown(UalaError(rawValue: rawValue) ?? UalaError.internalServerError)
        }
    }
}
