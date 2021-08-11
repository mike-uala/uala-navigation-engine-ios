import Foundation

struct MexicoAccountMapper: MappeableType {
    
    typealias Result = AccountDTO    
    func map<T>(_ data: Data) -> T? {
        return AccountBuilder.account(dto: decode(data)) as? T
    }
}

struct AccountFeaturesMapper: MappeableType {
    typealias Result = FeaturesDTO
    func map<T>(_ data: Data) -> T? {
        return FeaturesBuilder.features(dto: decode(data)) as? T
    }
}

struct UpdateAccountMapper: Mappeable {
    func map<T>(_ data: Data) -> T? {
        return () as? T
    }
}

struct CreatePinMapper: Mappeable {
    func map<T>(_ data: Data) -> T? {
        return () as? T
    }
}

struct UpdateUserEmail: Mappeable {
    func map<T>(_ data: Data) -> T? {
        return () as? T
    }
}
