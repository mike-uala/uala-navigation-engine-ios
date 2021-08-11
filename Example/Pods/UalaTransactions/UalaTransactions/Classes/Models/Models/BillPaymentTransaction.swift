import Foundation

public class BillPaymentTransaction: Payment {
    
    public var hasReceipt: Bool?
    
    init(_ transaction: Transaction, _ providerTransactionId: String?, _ hasReceipt: Bool?) {
        
        super.init(transaction, providerTransactionId)
        
        self.hasReceipt = hasReceipt
        amount?.makeNegative()        
    }
}
