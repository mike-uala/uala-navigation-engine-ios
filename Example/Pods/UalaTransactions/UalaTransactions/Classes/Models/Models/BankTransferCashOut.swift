
import Foundation

public class BankTransferCashOut: Transaction {
    
    public var cbu: String?
    public var bank: String?
    
    init(_ transaction: Transaction, _ cbu: String?, _ bank: String?) {
        
        super.init(transactionId: transaction.transactionId,
                   date: transaction.transactionDate,
                   amount: transaction.amount,
                   type: transaction.type,
                   status: transaction.status,
                   reconciliationStatus: nil,
                   currency: nil,
                   message: nil,
                   description: nil,
                   category: nil,
                   installmentAllowed: transaction.installmentAllowed)
        
        amount?.setImpactBalance(status != .canceled)
        amount?.makeNegative()
        self.cbu = cbu
        self.bank = bank
    }        
}
