//
//  TransactionStatus.swift
//  UalaTransactions
//
//  Created by Rodrigo German Ferretty on 20/01/2020.
//

import Foundation

public enum TransactionStatus: String {
    case unknown
    case created = "CREATED"
    case processed = "PROCESSED"
    case confirmed = "CONFIRMED"
    case externalWSError = "EXTERNAL_WS_ERROR"
    case externalBankError = "EXTERNAL_BANK_ERROR"
    case error = "ERROR"
    case authorized = "AUTHORIZED"
    case rejected = "REJECTED"
    case expired = "EXPIRED"
    case canceled = "CANCELED"
}
