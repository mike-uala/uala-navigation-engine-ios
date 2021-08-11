//
//  GenericPromoADPA.swift
//  UalaTransactions
//
//  Created by Christian Correa on 12/03/21.
//

import Foundation

public class GenericPromoADPA: Transaction {
        
    init(_ transaction: Transaction) {
        super.init(transactionId: transaction.transactionId,
                   date: transaction.transactionDate,
                   amount: transaction.amount,
                   type: transaction.type,
                   status: transaction.status,
                   reconciliationStatus: nil,
                   currency: nil,
                   message: nil,
                   description: transaction.description,
                   category: transaction.category,
                   installmentAllowed: transaction.installmentAllowed)
        
        amount?.makeNegative()
    }
}
