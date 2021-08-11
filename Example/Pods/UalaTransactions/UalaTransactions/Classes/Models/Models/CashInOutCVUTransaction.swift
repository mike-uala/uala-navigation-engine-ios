//
//  CashInCVUTransaction.swift
//  Uala
//
//  Created by Rodrigo Ferretty on 17/05/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import UalaCore

public class CashInOutCVUTransaction: Transaction {
    public var address: String?
    public var isCvu: Bool?
    public var addressName: String?
    public var claimNumber: String?
    public var operationId: String?
    var comment: String?
    
    private init(_ transaction: Transaction) {
        super.init(transactionId: transaction.transactionId,
                   date: transaction.transactionDate,
                   amount: transaction.amount,
                   type: transaction.type,
                   status: transaction.status,
                   reconciliationStatus: nil,
                   currency: nil,
                   message: transaction.message,
                   description: transaction.description,
                   category: transaction.category,
                   installmentAllowed: transaction.installmentAllowed)
    }

    
    convenience init(_ transaction: Transaction, _ origin: String, _ destination: String, _ comment: String, _ claimNumber: String?, operationId: String?) {
        self.init(transaction)
        let origDestAddress = type == .cashInCVU ? origin : destination
        self.address = UalaValidator().validate(cbuString: origDestAddress).isValid ? origDestAddress : nil
        self.isCvu = CBU.isCVU(for: self.address)
        self.addressName = CBU.getBankOrWalletName(for: self.address)
        self.comment = comment
        self.claimNumber = claimNumber
        self.operationId = operationId
        
        let notImpactBalance = status == .error || status == .externalWSError || status == .canceled
        amount?.setImpactBalance(!notImpactBalance)
        
        if type == .cashOutCVU { self.amount?.makeNegative() }
    }
    
    convenience init(_ transaction: Transaction, _ trackingKey: String?) {
        self.init(transaction)
        self.trackingKey = trackingKey
    }
    
    public func isClaimed() -> Bool {
        return claimNumber != nil
    }
    
}

