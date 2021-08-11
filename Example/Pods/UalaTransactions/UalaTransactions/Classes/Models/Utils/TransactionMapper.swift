//
//  TransactionMapper.swift
//  Uala
//
//  Created by Nicolas on 23/05/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON
import UalaCore

class TransactionMapper {

// MARK: - New mapping function
    private static func map(from DTOModel: TransactionDTO) -> Transaction? {
        
        guard let transactionDate = dateFrom(DTOModel.transactionDate),
              let transactionId = DTOModel.transactionID else { return nil }
        
        let creationDate = dateFrom(DTOModel.createdDate)
        var currencyValue = (amount: Money(0), code: "")
        let message = DTOModel.message
        let description = DTOModel.description
        let reconcilationValue = DTOModel.reconciliationStatus
        let metadataValue = DTOModel.metadata
        let hasReceipt = Bool(DTOModel.hasReceipt ?? "false")
        let installmentAllowed = Bool(DTOModel.installmentAllowed ?? "false")
        
        if let currencyDTO = DTOModel.currency,
            let amount = Double(currencyDTO.amount ?? "0"),
            let code = currencyDTO.code {
                currencyValue = (Money(amount), code)
        }
        
        
        let amountValue = Double(DTOModel.amount ?? "0")
        let amount = Money(amountValue)
        
        let typeValue = DTOModel.type
        let type = TransactionType(rawValue: typeValue ?? "") ?? .unknown
        
        let labelValue = DTOModel.label
        let category = TransactionCategory.init(safeRawValue: labelValue ?? "")
        
        let statusValue = DTOModel.status
        let status = TransactionStatus(rawValue: statusValue ?? "") ?? .unknown
        
        let currency = Currency(amount: currencyValue.amount, code: currencyValue.code)
        let reconciliationStatus = ReconciliationStatus(rawValue: reconcilationValue ?? "") ?? .reconcilied
        
        let forced = Bool(DTOModel.forced ?? "false") ?? false
        let reason = DTOModel.reason
        let externalId = DTOModel.externalId
        
        let transactionModel = Transaction(transactionId: transactionId,
                                           date: transactionDate,
                                           amount: amount,
                                           type: type,
                                           status: status,
                                           reconciliationStatus: reconciliationStatus,
                                           currency: currency,
                                           message: message,
                                           description: description,
                                           category: category,
                                           installmentAllowed: installmentAllowed ?? false,
                                           isForced: forced,
                                           reason: reason,
                                           externalId: externalId)
        
        let metadata = BancarMetadata(with: metadataValue ?? "")
        
        return TransactionFactory.createTransaction(transactionModel, metadata, creationDate, hasReceipt)
    }
    
    private static func dateFrom(_ date: Any?) -> Date? {
        // Date sometimes comes as milliseconds - workaround
        if let stringDate = date as? String {
            if let value = Double(stringDate) {
                return Date(timeIntervalSince1970: TimeInterval(Int(value) / 1000))
            } else if let dateFromString = Date.fromBancarString(strDate: stringDate) {
                return dateFromString
            }
        }
        return nil
    }
    
    private static var dataFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let environment: Environment = ServiceLocator.inject()
        if environment is Mexico {
            dateFormatter.locale =  Locale(identifier: "es_MX")
        } else if environment is Argentina {
            dateFormatter.locale =  Locale(identifier: "es_AR")
        }
        return dateFormatter
    }()
    
    private static func map(from dto: CommonTransactionDTO) -> Transaction? {
                        
        let date = self.dataFormatter.date(from: dto.formattedTransactionDate)!
        var amount = Money(dto.amount)
        let operationType = OperationType(rawValue: dto.operationType)
        let transactionType = TransactionType(rawValue: dto.type)
        let status = TransactionStatus(rawValue: dto.status) ?? .unknown
        let currency = Currency(amount: amount, code: dto.currencyCode)
            
        guard let type = transactionType, let operation = operationType else { return nil }
        
        if operation == .debit {
            amount.makeNegative()
        }
        
        let transaction = Transaction(transactionId: dto.transactionId,
                                      date: date,
                                      amount: amount,
                                      type: type,
                                      status: status,
                                      currency: currency,
                                      description: dto.description,
                                      institutionName: dto.institutionName,
                                      receiptNumber: dto.receiptNumber,
                                      accountNumber: dto.accountNumber,
                                      localCurrencyAmount: dto.localCurrencyAmount,
                                      exchangeType: dto.exchangeType,
                                      originAccount: dto.originAccount,
                                      trackingKey: dto.trackingKey,
                                      clabe: dto.clabe)
                        
        return TransactionFactory.createTransaction(transaction, dto, operation)
    }
    
    static func map<T: Codable>(dto: T) -> Transaction? {
        switch dto {
        case let dto as TransactionDTO:
            return self.map(from: dto)
        case let dto as CommonTransactionDTO:
            return self.map(from: dto)
        default:
            return nil
        }
    }
}

