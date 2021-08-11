//
//  Charge.swift
//  UalaTransactions
//
//  Created by Federico Andres Flores on 19/02/2021.
//

import Foundation

public class Charge: Transaction {
    public var IVA: Double?
    public var IIGG: Double?
    public var IIBB: Double?
    public var retentions: Double?
    public var comission: Double?
    public var totalGross: Double?
    public var buyerEmail: String?
    public var lastFourDigits: String?
    public var cardHolderName: String?

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

    convenience init(_ transaction: Transaction, _ IVA: Double, _ IIGG: Double, _ IIBB: Double, _ retentions: Double, _ comission: Double, _ totalGross: Double, _ buyerEmail: String, _ lastFourDigits: String, cardHolderName: String)  {
        self.init(transaction)

        self.IVA = IVA
        self.IIGG = IIGG
        self.IIBB = IIBB
        self.retentions = retentions
        self.comission = comission
        self.totalGross = totalGross
        self.buyerEmail = buyerEmail
        self.lastFourDigits = lastFourDigits
        self.cardHolderName = cardHolderName
    }
}
