import Foundation
import SwiftyJSON


public protocol ErrorCode {
    var code: Int { get set }
}

struct CoreError: Error, ErrorCode {
    var code: Int
}

extension CoreError {
    
    init?(error: JSON) {
        guard let code = Int(error["code"].stringValue) else {
            return nil
        }
        
        self.code = code
    }
}
