import Foundation
import UalaCore

protocol API {
    var transactions: TransactionsAPI { get }
}

extension Argentina: API {
    var transactions: TransactionsAPI {
        TransactionsAPI(ArgTransactionsAPIManager())
    }
}

extension API {
    var transactions: TransactionsAPI {
        TransactionsAPI(TransactionsAPIManager())
    }
}

extension Mexico: API {}

extension Colombia: API {}
