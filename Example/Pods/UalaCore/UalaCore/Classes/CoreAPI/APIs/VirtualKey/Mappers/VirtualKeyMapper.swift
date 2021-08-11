import Foundation

struct MexClabeMapper: MappeableType {
    typealias Result = CLABEResponseDTO
    
    func map<T>(_ data: Data) -> T? {
        return VirtualKey(from:  decode(data)) as? T
    }
}
