import Foundation

struct OOBMapper: MappeableType {
    struct Result: Decodable {
        var oob_code: String
    }

    func map<T>(_ data: Data) -> T? {
        return decode(data)?.oob_code as? T
    }
}

struct CrendentialMapper: Mappeable {

    func map<T>(_ data: Data) -> T? {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        return CredentialBuilder.create(json) as? T
    }
}
