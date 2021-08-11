import Foundation
struct ArgCVUMapper: MappeableType {
    typealias Result = CVUResponseDTO
    
    func map<T>(_ data: Data) -> T? {
        return VirtualKey(from:  decode(data)) as? T
    }
}

struct ArgCVUErrorMapper: MappeableType {
    struct Result: Decodable {
        let code: String?
    }

    public func map<T>(_ data: Data) -> T? {
        guard let errorCode = decode(data)?.code, let errorInt = Int(errorCode) else {
            return UalaError.undefined as? T
        }
        return UalaError(code: errorInt) as? T
    }
}
