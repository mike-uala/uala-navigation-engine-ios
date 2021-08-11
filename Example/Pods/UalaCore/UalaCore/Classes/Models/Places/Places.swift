import Foundation

public struct AddressItem: Decodable {
    public var id: Int?
    public var name: String

    public init(name: String, id: Int?) {
        self.name = name
        self.id = id
    }
    
    public init(name: String) {
        self.name = name
    }
}

public struct ProvinceAndLocalities: Decodable {
    
    public var locality: String
    public var province: String
    public var provinceId: Int?

    enum CodingKeys: String, CodingKey {
        case locality, province, provinceId = "province_id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.locality = (try? container.decode( String.self, forKey: .locality)) ?? ""
        self.province = (try? container.decode( String.self, forKey: .province)) ?? ""
        self.provinceId = try? container.decode(Int.self, forKey: .provinceId)
    }
}

extension AddressItem: Hashable { }
