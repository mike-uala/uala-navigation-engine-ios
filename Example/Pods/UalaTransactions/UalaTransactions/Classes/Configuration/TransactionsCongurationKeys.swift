//
//  TransactionsCongurationKeys.swift
//  UalaTransactions
//
//  Created by Monserrath Castro on 20/07/21.
//

import Foundation
import UalaCore

//MARK: Saleforce Configuration Keys
extension ConfigurationKey {
    static let SFCRMURL = ConfigurationKey(rawValue: "SF_CRM_URL")
    static let SFChatStatusURL = ConfigurationKey(rawValue: "SF_CHAT_STATUS_URL")
    static let SFChatStatusARGURL = ConfigurationKey(rawValue: "SF_CHAT_STATUS_ARG_URL")
    static let SFChatStatusMXURL = ConfigurationKey(rawValue: "SF_CHAT_STATUS_MX_URL")
}
