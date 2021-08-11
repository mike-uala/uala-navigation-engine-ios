import Foundation
import PromiseKit
import UalaCore
import Alamofire

public protocol TransactionRepositoryProtocol {
    func getCVUTransactionStatus(authId: String) -> Promise<TransactionStatus>
    func getUserToUserTransactionStatus(transactionId: String) -> Promise<TransactionStatus>
    func updateTransactionCategory(transactionId: String, category: TransactionCategory) -> Promise<Transaction>
    func updateComment(transactionId: String, comment: String) -> Promise<Transaction>
    func claimTransaction(transactionId: String) -> Promise<Claim>
    func getTransaction(by transactionId: String) -> Transaction?
}

public class TransactionRepository: TransactionRepositoryProtocol {
    
    let APIManager: BaseApiManager = ServiceLocator.inject()
    
    public init() {}
    
    public func getCVUTransactionStatus(authId: String) -> Promise<TransactionStatus> {
        return Promise<TransactionStatus> { seal in
            APIManager.requestApi2(path: "transactions/\(authId)", method: .get).done { json in
                let txStatus = TransactionStatus(rawValue: json["status"].stringValue ) ?? .unknown
                guard [TransactionStatus.confirmed, .authorized, .canceled].contains(txStatus) else {
                    seal.reject(UalaError.undefined)
                    return
                }
                seal.fulfill(txStatus)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    public func getUserToUserTransactionStatus(transactionId: String) -> Promise<TransactionStatus> {
        return Promise<TransactionStatus> { seal in
            APIManager.requestApi1(path: "transactions/\(transactionId)", method: .get).done { json in
                let txStatus = TransactionStatus(rawValue: json["transaction"]["status"].stringValue ) ?? .unknown
                guard [TransactionStatus.confirmed, .authorized, .error, .externalWSError, .canceled].contains(txStatus) else {
                    seal.reject(UalaError.undefined)
                    return
                }
                seal.fulfill(txStatus)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    public func updateTransactionCategory(transactionId: String, category: TransactionCategory) -> Promise<Transaction> {
        
        if let transaction = getTransaction(by: transactionId)  {
            transaction.category = category
        }
        
        return Promise<Transaction> { seal in
            var bodyParameters: Parameters = [:]
            bodyParameters["labelName"] = category.rawValue
            
            _ = self.APIManager.requestApi1(path: "transactions/\(transactionId)", method: .put, parameters: bodyParameters, encoding: JSONEncoding.default).done { (json) in
                guard let jsonData = try? json["transaction"].rawData(),
                    let tx = try? JSONDecoder().decode(TransactionDTO.self, from: jsonData),
                    let transaction = TransactionMapper.map(dto: tx) else {
                        seal.reject(UalaError.noTransactionsFound)
                        return
                }
                seal.fulfill(transaction)
            }.catch { error in
                seal.reject(UalaError(error: error))
            }
        }
    }
    
    public func updateComment(transactionId: String, comment: String) -> Promise<Transaction> {
        if let transaction = getTransaction(by: transactionId)  {
            transaction.message = comment
        }
        
        return Promise<Transaction> { seal in
            var bodyParameters: Parameters = [:]
            bodyParameters["comment"] = comment
            
            _ = self.APIManager.requestApi1(path: "transactions/\(transactionId)", method: .put, parameters: bodyParameters, encoding: JSONEncoding.default).done { (json) in
                guard let jsonData = try? json["transaction"].rawData(),
                    let tx = try? JSONDecoder().decode(TransactionDTO.self, from: jsonData),
                    let transaction = TransactionMapper.map(dto: tx) else {
                        seal.reject(UalaError.noTransactionsFound)
                        return
                }
                seal.fulfill(transaction)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    public func claimTransaction(transactionId: String) -> Promise<Claim> {
        var bodyParameters: Parameters = [:]
        bodyParameters["transactionId"] = transactionId
        
        return Promise<Claim> { seal in
            APIManager.requestApi2(path: "zendesk/ticket", method: .post, parameters: bodyParameters, encoding: JSONEncoding.default).done { json in
                guard let jsonData = try? json.rawData(),
                    let claimDTO = try? JSONDecoder().decode(ClaimDTO.self, from: jsonData),
                    let claim = ClaimMapper.map(from: claimDTO) else {
                        seal.reject(UalaError.undefined)
                        return
                }
                seal.fulfill(claim)
            }.catch { error in
                seal.reject(error)
            }
        }
        
    }
    
    public func getTransaction(by transactionId: String) -> Transaction? {
        guard let transactions = TransactionsSessionData.transactions else { return nil }
        return transactions.filter({ $0.transactionId == transactionId }).first
    }
}
