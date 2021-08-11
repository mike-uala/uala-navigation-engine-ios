import Foundation

struct ArgAccountMapper: MappeableType {
    
    struct Result: Decodable {
        let accounts: [AccountDTO]
    }
    
    func map<T>(_ data: Data) -> T? {
        return AccountBuilder.account(dto: decode(data)?.accounts.first) as? T
    }
}
