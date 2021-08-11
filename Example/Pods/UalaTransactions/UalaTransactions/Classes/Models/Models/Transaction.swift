//
//  Transaction.swift
//  Uala
//
//  Created by Hasael Oliveros on 7/24/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UalaCore

public struct Currency {
    public let amount: Money?
    public let code: String?
    
    public func isARS() -> Bool {
        return code == "32" || code == "032"
    }
}

public class Transaction {
    internal init(transference: Transaction.Transference?,
                  recharge: Transaction.Recharge?,
                  adjustment: String?,
                  payment: Transaction.Payment?,
                  transactionId: String,
                  transactionDate: Date,
                  amount: Money?,
                  type: TransactionType,
                  status: TransactionStatus?,
                  reconciliationStatus: ReconciliationStatus?,
                  currency: Currency?,
                  message: String?,
                  description: String?,
                  category: TransactionCategory?,
                  error: RejectedCode?,
                  installmentAllowed: Bool,
                  isOverMaxBalance: Bool?,
                  isForced: Bool = false,
                  reason: String? = nil,
                  externalId: String? = nil,
                  institutionName: String? = nil,
                  receiptNumber: String? = nil,
                  accountNumber: String? = nil,
                  localCurrencyAmount: Double? = nil,
                  exchangeType: Double? = nil,
                  originAccount: Int? = nil,
                  trackingKey: String? = nil,
                  clabe: String? = nil) {
        self.transference = transference
        self.recharge = recharge
        self.adjustment = adjustment
        self.payment = payment
        self.transactionId = transactionId
        self.transactionDate = transactionDate
        self.amount = amount
        self.type = type
        self.status = status
        self.reconciliationStatus = reconciliationStatus
        self.currency = currency
        self.message = message
        self.description = description
        self.category = category
        self.error = error
        self.installmentAllowed = installmentAllowed
        self.isOverMaxBalance = isOverMaxBalance
        self.forced = isForced
        self.forcedReason = reason
        self.externalId = externalId
        self.institutionName = institutionName
        self.receiptNumber = receiptNumber
        self.accountNumber = accountNumber
        self.localCurrencyAmount = localCurrencyAmount
        self.exchangeType = exchangeType
        self.originAccount = originAccount
        self.trackingKey = trackingKey
        self.clabe = clabe
    }
    
    struct Transference {
        let sender: Contact?
        let recipient: Contact?
    }
    
    public struct Recharge {
        public let icon: String
        let description: String
        let providerId: String?
        public let rechargeModel: ConsumptionModel?
        public let errorCode: String?
    }
    
    struct CashInOutCVU {
        let originAddress: String
        let destination: String
        let comment: String
        let claimNumber: String?
        let operationId: String?
    }
    
    struct CashInCharge {
        let IVA: Double
        let IIGG: Double
        let IIBB: Double
        let retentions: Double
        let commissionTotal: Double
        let commissionIva: Double
        let totalGross: Double
        let buyerEmail: String
        let lastFourDigits: String
        let cardHolderName: String
    }
    
    struct Investment {
        let rescueType: String?
    }
    
    struct Adjustment {
        let conceptCode: AdjustmentCode?
        let IVA: Double?
        let baseAmount: Double?
    }
    
    public struct Payment {
        public let paymentId: String
    }
    
    var transference: Transference?
    var recharge: Recharge?
    var adjustment: String?
    public var payment: Payment?
    var showErrorFormat: Bool = true
    public let transactionId: String
    public var transactionDate: Date
    public var amount: Money?
    public var type: TransactionType
    public let status: TransactionStatus?
    public var reconciliationStatus: ReconciliationStatus?
    public var currency: Currency?
    public var message: String?
    public var description: String?
    public var category: TransactionCategory? = .withoutCategory
    public var error: RejectedCode?
    public var installmentAllowed: Bool = false
    public var isOverMaxBalance: Bool?
    public var forced: Bool?
    public var forcedReason: String?
    public var externalId: String?
    public var institutionName: String?
    public var receiptNumber: String?
    public var accountNumber: String?
    public var localCurrencyAmount: Double?
    public var exchangeType: Double?
    public var originAccount: Int?
    public var trackingKey: String?
    public var clabe: String?

    public init(transactionId: String,
                date: Date,
                amount: Money?,
                type: TransactionType,
                status: TransactionStatus?,
                reconciliationStatus: ReconciliationStatus?,
                currency: Currency?,
                message: String?,
                description: String?,
                category: TransactionCategory?,
                error: RejectedCode? = nil,
                installmentAllowed: Bool,
                isForced: Bool = false,
                reason: String? = nil,
                externalId: String? = nil,
                institutionName: String? = nil,
                receiptNumber: String? = nil,
                accountNumber: String? = nil,
                localCurrencyAmount: Double? = nil,
                exchangeType: Double? = nil,
                originAccount: Int? = nil,
                trackingKey: String? = nil,
                clabe: String? = nil) {
        
        self.transactionId = transactionId
        self.transactionDate = date
        self.amount = amount
        self.type = type
        self.status = status
        self.reconciliationStatus = reconciliationStatus
        self.currency = currency
        self.message = message
        self.description = description
        self.category = category
        self.error = error
        self.installmentAllowed = installmentAllowed
        self.forced = isForced
        self.forcedReason = reason
        self.externalId = externalId
        self.institutionName = institutionName
        self.receiptNumber = receiptNumber
        self.accountNumber = accountNumber
        self.localCurrencyAmount = localCurrencyAmount
        self.exchangeType = exchangeType
        self.originAccount = originAccount
        self.trackingKey = trackingKey
        self.clabe = clabe
    }
    
    public init(transactionId: String,
                date: Date,
                amount: Money?,
                type: TransactionType,
                status: TransactionStatus?,
                description: String?,
                institutionName: String? = nil,
                receiptNumber: String? = nil,
                accountNumber: String? = nil,
                localCurrencyAmount: Double? = nil,
                exchangeType: Double? = nil,
                originAccount: Int? = nil,
                trackingKey: String? = nil,
                clabe: String? = nil) {
        
        self.type = type
        self.status = status
        self.amount = amount
        self.transactionDate = date
        self.description = description
        self.transactionId = transactionId
        self.institutionName = institutionName
        self.receiptNumber = receiptNumber
        self.accountNumber = accountNumber
        self.localCurrencyAmount = localCurrencyAmount
        self.exchangeType = exchangeType
        self.originAccount = originAccount
        self.trackingKey = trackingKey
        self.clabe = clabe
    }
    
    public init(transactionId: String,
                date: Date,
                amount: Money?,
                type: TransactionType,
                status: TransactionStatus?,
                currency: Currency?,
                description: String?,
                institutionName: String? = nil,
                receiptNumber: String? = nil,
                accountNumber: String? = nil,
                localCurrencyAmount: Double? = nil,
                exchangeType: Double? = nil,
                originAccount: Int? = nil,
                trackingKey: String? = nil,
                clabe: String? = nil) {
        
        self.type = type
        self.status = status
        self.amount = amount
        self.currency = currency
        self.transactionDate = date
        self.description = description
        self.transactionId = transactionId
        self.institutionName = institutionName
        self.receiptNumber = receiptNumber
        self.accountNumber = accountNumber
        self.localCurrencyAmount = localCurrencyAmount
        self.exchangeType = exchangeType
        self.originAccount = originAccount
        self.trackingKey = trackingKey
        self.clabe = clabe
    }
    
    public func showInChart() -> Bool {
        let valid: [TransactionType] = [.consumptionPOS, .automaticDebit, .recharge, .billPayment, .userToUser, .userToUserReceived]
        if category != nil, let amount = amount, valid.contains(type), amount.isImpactBalance() { return true }
        return false
    }
    
    func isCanceledPayment() -> Bool {
        let isCanceled = self.status == .canceled
        return (isCanceled && self.type == .recharge ) ||
            ((self.type == .userToUser || self.type == .userToUserReceived) && (self.status == .error || self.status == .externalWSError))
    }
    
    public func isConfirmed() -> Bool {
        return self.status != .canceled && self.status != .error
    }
}
