//
//  SalesforceRoutable.swift
//  UalaTransactions
//
//  Created by Enzo Digiano on 06/11/2020.
//

import Foundation
import Alamofire
import UalaCore

public enum SalesforceRoute {
    case cashOutCVU(transactionId: String)
    case cashInCVU(name: String, dni: String, date: String, file: String, fileExtension: String, amount: String)
    case cashInCash(entity: String, date: String, file: String, fileExtension: String, amount: String)
    case genericCase(message: String)
    case getChatStatus
    case getChatStatusARG
    case getChatStatusMX
}

public protocol SalesforceRouteable: Routeable {
    var route: SalesforceRoute { get set }
}

extension SalesforceRouteable {
    var baseUrl: String {
        return String.getConfigurationValue(forKey: self.configKey, from: .Transactions)
    }

    private var configKey: ConfigurationKey {
        switch route {
        case .getChatStatus:            return .SFChatStatusURL
        case .getChatStatusARG:         return .SFChatStatusARGURL
        case .getChatStatusMX:          return .SFChatStatusMXURL
        default:                        return .SFCRMURL
        }
    }
    
    public var path: String {
        switch route {
        case .getChatStatus:
            return ""
        case .getChatStatusARG:
            return "/cxapp/crmv2/chatstatus"
        case .getChatStatusMX:
            return "/cxapp/crm_cxapp/chatstatus"
        default:
            return "/cxapp/crm/case"
        }
    }

    var method: HTTPMethod {
        switch route {
        case .getChatStatus, .getChatStatusARG, .getChatStatusMX:
            return .get
        default:
            return .post
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.prettyPrinted
    }
    
    var mapper: Mappeable {
        switch route {
        case .getChatStatus, .getChatStatusARG, .getChatStatusMX:
            return SalesforceChatStatusMapper()
        default:
            return SalesforceMapper()
        }
    }
    
    var parameters: Parameters? {
        switch route {
        case .cashOutCVU( let transactionId):
            return [ "type": "CASH_OUT_CVU",
                     "transactionId": transactionId]
        case .cashInCVU( let name, let dni, let date, let file, let fileExtension, let amount):
            return ["type": "CASH_IN_CVU",
                    "nameFrom": name,
                    "dniFrom": dni,
                    "date": date,
                    "fileBase64Str": file,
                    "fileExtension": fileExtension,
                    "amount": amount]
        case .cashInCash(let entity, let date, let file, let fileExtension, let amount):
            return ["type": "CASH_IN_CASH",
                    "entity": entity,
                    "date": date,
                    "fileBase64Str": file,
                    "fileExtension": fileExtension,
                    "amount": amount]
        case .genericCase(let message):
            return ["type": "GENERIC_CASE",
                    "message": message]
        case .getChatStatus, .getChatStatusARG, .getChatStatusMX:
            return nil
        }
    }
}

struct SalesforceRouter: SalesforceRouteable {
    var route: SalesforceRoute = .cashOutCVU(transactionId: "")
}
