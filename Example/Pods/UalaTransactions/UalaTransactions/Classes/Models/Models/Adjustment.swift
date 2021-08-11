import Foundation

public class Adjustment: Transaction {
    
    public var conceptCode: AdjustmentCode?
    public var IVA: Double?
    public var baseAmount: Double?
    
    init(_ transaction: Transaction, _ adjustmentMetadata: Transaction.Adjustment?, _ devolution: Bool) {
        
        super.init(transactionId: transaction.transactionId,
                   date: transaction.transactionDate,
                   amount: transaction.amount,
                   type: transaction.type,
                   status: nil,
                   reconciliationStatus: nil,
                   currency: nil,
                   message: nil,
                   description: transaction.description,
                   category: nil,
                   installmentAllowed: transaction.installmentAllowed)
        
        if !devolution {
            amount?.makeNegative()
        }
        
        self.conceptCode = adjustmentMetadata?.conceptCode
        self.IVA = adjustmentMetadata?.IVA
        self.baseAmount = adjustmentMetadata?.baseAmount
    }
}
