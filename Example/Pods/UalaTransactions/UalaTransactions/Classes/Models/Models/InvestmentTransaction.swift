import Foundation

public class InvestmentTransaction: Transaction {
    public var rescueType: String?
    
    init(_ transaction: Transaction, _ rescueType: String?) {
        
        super.init(transactionId: transaction.transactionId,
                   date: transaction.transactionDate,
                   amount: transaction.amount,
                   type: transaction.type,
                   status: transaction.status,
                   reconciliationStatus: nil,
                   currency: nil,
                   message: transaction.message,
                   description: nil,
                   category: nil,
                   installmentAllowed: transaction.installmentAllowed,
                   isForced: transaction.forced ?? false,
                   reason: transaction.forcedReason)
        
        self.rescueType = rescueType
    }
}
