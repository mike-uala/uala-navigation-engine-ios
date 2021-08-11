import Foundation
import UalaCore

public protocol Transfer {
    var contact: Contact? { get set }
    func displayName() -> String?
}

extension Transfer {
    public func displayName() -> String? {
        return contact?.displayName
    }
}

public class TransferSent: Transaction, Transfer {
    public var contact: Contact?
    
    init(_ transaction: Transaction, _ receiver: Contact?) {
        
        super.init(transactionId: transaction.transactionId,
                   date: transaction.transactionDate,
                   amount: transaction.amount,
                   type: transaction.type,
                   status: transaction.status,
                   reconciliationStatus: nil,
                   currency: nil,
                   message: transaction.message,
                   description: nil,
                   category: transaction.category,
                   installmentAllowed: transaction.installmentAllowed,
                   originAccount: transaction.originAccount)
        
        let notImpactBalance = status == .error || status == .externalWSError || status == .canceled
        amount?.setImpactBalance(!notImpactBalance)
        amount?.makeNegative()
        self.contact = receiver
    }
}
