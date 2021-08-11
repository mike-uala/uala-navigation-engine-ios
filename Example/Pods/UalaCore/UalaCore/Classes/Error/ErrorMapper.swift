import Foundation

class ErrorMapper: MappeableType {
    
    struct Result: Decodable {
        
        let code: Int?
        
        private enum CodingKeys : String, CodingKey {
            case code
        }
        
        init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
            
          if let intCode = try? container.decode(Int.self, forKey: .code) {
            code = intCode
          } else if let stringCode = try? container.decode(String.self, forKey: .code), let intCode = Int(stringCode) {
            code = intCode
          } else {
            code = nil
          }
        }
    }
    
    public func map<T>(_ data: Data) -> T? {
        guard let errorCode = decode(data)?.code else {
            return UalaError.undefined as? T
        }
        return UalaError(code: errorCode) as? T
    }
}

