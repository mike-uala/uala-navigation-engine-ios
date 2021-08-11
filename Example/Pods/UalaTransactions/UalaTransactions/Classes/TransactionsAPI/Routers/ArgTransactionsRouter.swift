import UalaCore

struct ArgTransactionsRouter: TransactionsRouteable {
        
    var route: TransactionsRoute = .transactions(nil)
    
    var path: String {
        "/2/transactions"
    }
    
    var mapper: Mappeable {
        TransactionsMapper<TransactionDTO>()
    }
}
