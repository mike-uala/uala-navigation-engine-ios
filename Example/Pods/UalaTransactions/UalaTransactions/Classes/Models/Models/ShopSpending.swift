import Foundation

public class ShopSpending: Transaction {
    public var taxes: [String: Money] = [:]
    public var iibbProvince: String?

    init?(_ transaction: Transaction, _ taxes: [String: Money] = [:], _ iibbProvince: String? = nil) {
        
        super.init(transactionId: transaction.transactionId,
                   date: transaction.transactionDate,
                   amount: transaction.amount,
                   type: transaction.type,
                   status: transaction.status,
                   reconciliationStatus: transaction.reconciliationStatus,
                   currency: transaction.currency,
                   message: transaction.message,
                   description: transaction.description,
                   category: transaction.category,
                   error: transaction.error,
                   installmentAllowed: transaction.installmentAllowed,
                   localCurrencyAmount: transaction.localCurrencyAmount,
                   exchangeType: transaction.exchangeType)
        
        var devolution = false
        
        switch transaction.status ?? .unknown {
        case .rejected: amount?.setImpactBalance(false)
        case .canceled: devolution = true
        case .error, .externalWSError, .externalBankError, .expired: return nil
        default: break
        }
        
        devolution = type == .refund ? true : devolution
        
        if !devolution { amount?.makeNegative() }
        
        self.iibbProvince = iibbProvince
        self.taxes = taxes
    }
}
