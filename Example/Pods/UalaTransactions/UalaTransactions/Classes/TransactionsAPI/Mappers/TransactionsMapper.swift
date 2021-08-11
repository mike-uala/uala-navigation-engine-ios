import Foundation
import UalaCore

struct TransactionsMapper<DTO: Codable>: MappeableType {
    
    struct Result: Decodable {
        let transactions: [DTO]
    }
    
    func map<T>(_ data: Data) -> T? {
        let txs: [DTO]? = decode(data)?.transactions
        return txs?.compactMap({ TransactionMapper.map(dto: $0) }) as? T
    }
}
