import Foundation

public class Payment: Transaction {
    
    public var providerTransactionId: String?
    
    init(_ transaction: Transaction, _ providerTransactionId: String?) {
        
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
        
        self.providerTransactionId = providerTransactionId
        amount?.setImpactBalance(status != .canceled)
    }
}
