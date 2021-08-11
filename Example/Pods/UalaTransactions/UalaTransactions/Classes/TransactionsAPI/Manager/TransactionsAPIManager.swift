import Foundation
import UalaCore

public protocol TransactionsAPIManagerProtocol {
    var transactions: TransactionsRouteable { get set }
}

public struct TransactionsAPI {
    private var API: TransactionsAPIManagerProtocol
    
    init(_ API: TransactionsAPIManagerProtocol) {
        self.API = API
    }
}

public extension TransactionsAPI {
    mutating func transactionsAPI(route: TransactionsRoute) -> Routeable {
        API.transactions.route = route
        return API.transactions
    }
}

struct ArgTransactionsAPIManager: TransactionsAPIManagerProtocol {
    var transactions: TransactionsRouteable = ArgTransactionsRouter()
}

struct TransactionsAPIManager: TransactionsAPIManagerProtocol {
    var transactions: TransactionsRouteable = TransactionsRouter()
}
