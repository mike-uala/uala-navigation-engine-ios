import Foundation

public class Recharge: Payment {
    public var request: Transaction.Recharge?
        
    init(_ transaction: Transaction, _ request: Transaction.Recharge, _ creationDate: Date?) {
        super.init(transaction, request.providerId)
        
        self.request = request
        amount?.makeNegative()
        transactionDate = creationDate!
        description = request.description
    }
}
