//
//  MockTransactionsRepository.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 22/06/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import UalaTransactions
import PromiseKit

class MockTransactionsRepository: TransactionRepositoryProtocol {
    
    func getCVUTransactionStatus(authId: String) -> Promise<TransactionStatus> {
        return Promise.value(TransactionStatus.authorized)
    }
    
    func getUserToUserTransactionStatus(transactionId: String) -> Promise<TransactionStatus> {
        return Promise.value(TransactionStatus.authorized)
    }
    
    func updateTransactionCategory(transactionId: String, category: TransactionCategory) -> Promise<Transaction> {
        
        return Promise.value(Transaction(transactionId: "", date: Date(), amount: Money(1000), type: .consumptionPOS, status: .authorized, reconciliationStatus: nil, currency: nil, message: nil, description: nil, category: nil, error: nil, installmentAllowed: false, isForced: false, reason: nil))
    }
    
    func updateComment(transactionId: String, comment: String) -> Promise<Transaction> {
        
        return Promise.value(Transaction(transactionId: "", date: Date(), amount: Money(1000), type: .consumptionPOS, status: .authorized, reconciliationStatus: nil, currency: nil, message: comment, description: nil, category: nil, error: nil, installmentAllowed: false, isForced: false, reason: nil))
    }
    
    func getTransaction(by transactionId: String) -> Transaction? {
        
        return Transaction(transactionId: "", date: Date(), amount: Money(1000), type: .consumptionPOS, status: .authorized, reconciliationStatus: nil, currency: nil, message: nil, description: nil, category: nil, error: nil, installmentAllowed: false, isForced: false, reason: nil)
    }
    
    func claimTransaction(transactionId: String) -> Promise<Claim> {
        return Promise.value(Claim(claimNumber: nil))
    }
    
}
