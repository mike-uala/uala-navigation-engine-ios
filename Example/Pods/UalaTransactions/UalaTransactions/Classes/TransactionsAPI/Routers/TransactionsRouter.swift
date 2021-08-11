import UalaCore

struct TransactionsRouter: TransactionsRouteable {
        
    var route: TransactionsRoute = .transactions(nil)
    
    var path: String {
        "/1/transactions"
    }
    
    var mapper: Mappeable {
        TransactionsMapper<CommonTransactionDTO>()
    }
}
