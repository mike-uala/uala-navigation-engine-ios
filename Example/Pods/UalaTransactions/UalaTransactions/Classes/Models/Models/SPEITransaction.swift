//
//  SPEITransaction.swift
//  UalaTransactions
//
//  Created by Christian Correa on 05/04/21.
//

import Foundation
import UalaCore

public class SPEITransaction: Transaction, Transfer {
    
    public var contact: Contact?

    private init(_ transaction: Transaction) {
        super.init(transactionId: transaction.transactionId,
                   date: transaction.transactionDate,
                   amount: transaction.amount,
                   type: transaction.type,
                   status: transaction.status,
                   reconciliationStatus: nil,
                   currency: transaction.currency,
                   message: transaction.message,
                   description: transaction.description,
                   category: transaction.category,
                   installmentAllowed: transaction.installmentAllowed,
                   originAccount: transaction.originAccount,
                   trackingKey: transaction.trackingKey,
                   clabe: transaction.clabe)
    }
    
    convenience init(_ transaction: Transaction, _ trackingKey: String? = nil) {
        self.init(transaction)
        
        if let trackingKeyValue = trackingKey {
            self.trackingKey = trackingKeyValue
        }
        
        self.contact = transaction.type == .userToUser ? transaction.transference?.recipient : transaction.transference?.sender
    }
}
