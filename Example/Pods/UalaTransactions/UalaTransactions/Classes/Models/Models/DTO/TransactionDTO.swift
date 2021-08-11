//
//  TransactionDTO.swift
//  UalaTransactions
//
//  Created by Rodrigo German Ferretty on 02/01/2020.
//
//   let transactionDTO = try? newJSONDecoder().decode(TransactionDTO.self, from: jsonData)

import Foundation

//// MARK: - TransactionDTO
//struct TransactionDTO: Codable {
//    let accountIDFrom, accountIDTo: String
//    let amount: String
//    let createdDate: String
//    let currency: CurrencyDTO
//    let description: String
//    let hasReceipt, installmentAllowed: Bool
//    let label, message, metadata, reconciliationStatus: String
//    let status, transactionDate, transactionID, type: String
//    let updatedDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case accountIDFrom = "accountIdFrom"
//        case accountIDTo = "accountIdTo"
//        case amount, createdDate, currency
//        case description = "description"
//        case hasReceipt, installmentAllowed, label, message, metadata, reconciliationStatus, status, transactionDate
//        case transactionID = "transactionId"
//        case type, updatedDate
//    }
//}
//
//// MARK: - CurrencyDTO
//struct CurrencyDTO: Codable {
//    let amount, code: Int
//}

// MARK: - TransactionDTO
public struct TransactionDTO: Codable {
    public let transactionID: String?
    let accountIDFrom, accountIDTo, type: String?
    let status, amount, reconciliationStatus, metadata: String?
    let currency: CurrencyDTO?
    let label, transactionDate, createdDate, updatedDate: String?
    let message, description, hasReceipt, installmentAllowed: String?
    let forced, reason, externalId: String?

    enum CodingKeys: String, CodingKey {
        case accountIDFrom = "accountIdFrom"
        case accountIDTo = "accountIdTo"
        case transactionID = "transactionId"
        case type, status, amount, reconciliationStatus, metadata, currency, label, transactionDate, createdDate, updatedDate, message, description, forced, reason, externalId
        case hasReceipt, installmentAllowed
    }
}

// MARK: - Currency
struct CurrencyDTO: Codable {
    let code, amount: String?
}

struct CommonTransactionDTO: Codable {
    let type: String
    let amount: Double
    let currencyCode: String?
    let status: String
    let transactionId: String
    let operationType: String
    let formattedTransactionDate: String
    
    let description: String?
    let rejectedReason: String?
    let message: String?
    let receiver: String?
    let receiverName: String?
        
    let sender: String?
    let senderName: String?
    let externalProviderTransactionId: String?
    
    let institutionName: String?
    let receiptNumber: String?
    let accountNumber: String?
    let localCurrencyAmount: Double?
    let exchangeType: Double?
    let originAccount: Int?
    let trackingKey: String?
    let clabe: String?
}

