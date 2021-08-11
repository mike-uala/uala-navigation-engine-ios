import Foundation
import UalaCore

public class TransferReceived: Transaction, Transfer {
    public var contact: Contact?
    
    init(_ transaction: Transaction, _ sender: Contact?) {
        
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
                   installmentAllowed: transaction.installmentAllowed)
        
        let notImpactBalance = status == .error || status == .externalWSError
        amount?.setImpactBalance(!notImpactBalance)
        self.contact = sender
    }        
}
