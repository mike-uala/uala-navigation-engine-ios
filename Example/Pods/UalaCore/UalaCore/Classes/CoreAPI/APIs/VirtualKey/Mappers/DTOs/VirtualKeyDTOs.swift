import Foundation

struct CVUResponseDTO: Codable {
    let cvu, alias: String
}

struct CLABEResponseDTO: Codable {
    let clabe: String
}

struct ProductDTO: Codable {
    let productType: String
    let productStatus: String
    let productNumber: String
    let baseProduct: Bool
}

struct ResponseProductDTO: Codable {
    let products: [ProductDTO]
}
