import Foundation

struct ProvinceMap: MappeableType {
    struct Result: Decodable {
        var provinces: [AddressItem]
    }
    
    func map<T>(_ data: Data) -> T? {
        return decode(data)?.provinces as? T
    }
}

struct LocalityMap: MappeableType {
    struct Result: Decodable {
        var localities: [AddressItem]
    }
    
    func map<T>(_ data: Data) -> T? {
        return decode(data)?.localities as? T
    }
}

struct ZipCodeMap: MappeableType {
    struct Result: Decodable {
        var zip_codes: [String]
    }
    
    func map<T>(_ data: Data) -> T? {
        return decode(data)?.zip_codes.map({ AddressItem(name: $0) }) as? T
    }
}

struct ComposedProvinceMap: MappeableType {
    struct Result: Decodable {
        var localities: [ProvinceAndLocalities]
    }
    
    func map<T>(_ data: Data) -> T? {
        guard let composed = decode(data)?.localities else { return nil }
        let localities = composed.map { AddressItem(name: $0.locality) }
        let provinces = Set(composed.map { AddressItem(name: $0.province, id: $0.provinceId )})
        return (localities: localities, provinces: Array(provinces)) as? T
    }
}
