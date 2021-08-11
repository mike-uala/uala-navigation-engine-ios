import Foundation

public struct VirtualKey {
    public var key: String?
    public var alias: String?
    
    init?(from cvuDTO: CVUResponseDTO?) {
        guard let cvuResponse = cvuDTO else { return nil }
        self.key = cvuResponse.cvu
        self.alias = cvuResponse.alias
    }
    
    init?(from clabeDTO: CLABEResponseDTO?) {
        guard let clabeResponse = clabeDTO else { return nil }
        self.key = clabeResponse.clabe
    }
    
    init?(from responseProductsDTO: ResponseProductDTO?) {
        guard let responseProducts = responseProductsDTO else { return nil }
        responseProducts.products.forEach { product in
          if product.baseProduct {
            self.key = product.productNumber
          }
        }
    }
}
