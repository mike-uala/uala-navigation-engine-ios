//
//  TransactionsRepository.swift
//  UalaTransactions
//
//  Created by Rodrigo German Ferretty on 02/01/2020.
//

import Foundation
import PromiseKit
import SwiftyJSON
import Alamofire
import UalaCore

public protocol TransactionDelegate: AnyObject {
    func update(transaction: Transaction)
}

public protocol TransactionsRepositoryProtocol {
    func getSortedTransactions() -> Promise<[Transaction]>
    func getAllTransactions(of type: TransactionBackEndType) -> Promise<[Transaction]>
    func saveTransactions(txs: [Transaction])
    func getSavedTransactions(txs: [Transaction]) -> [Transaction]?
}

public class TransactionsRepository: BaseRepository, TransactionsRepositoryProtocol {
        
    private var transactions: TransactionsAPI
    
    public init(_ API: TransactionsAPI) {
        self.transactions = API
    }
    
    public func saveTransactions(txs: [Transaction]) {
        TransactionsSessionData.transactions = txs
    }
    
    public func getSavedTransactions(txs: [Transaction]) -> [Transaction]? {
        return TransactionsSessionData.transactions
    }
    
    //MARK: - Public API methods
    public func getSortedTransactions() -> Promise<[Transaction]> {
        return Promise<[Transaction]> { seal in
            getTransactions().done { transactions -> Void in
                let mergedTransactions = transactions.sorted { $0.transactionDate > $1.transactionDate }
                seal.fulfill(mergedTransactions)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    public func getAllTransactions(of type: TransactionBackEndType) -> Promise<[Transaction]> {
        return Promise<[Transaction]> { seal in
            getTransactions(with: type).done { transactions in
                seal.fulfill(transactions)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func getTransactions(with type: TransactionBackEndType? = nil) -> Promise<[Transaction]> {
        requestAuth(transactions.transactionsAPI(route: .transactions(type?.rawValue)))
    }
}
