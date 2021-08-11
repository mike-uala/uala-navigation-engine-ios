import Foundation
import UalaCore

public protocol CURule {
    var limit: Int { get }
    var keyboard: UIKeyboardType { get }
    func isValid(_ text: String) -> Bool
}

public class CBURule: CURule {
    
    public var limit = UalaValidator.cbuMaxLimit
    public var keyboard = UIKeyboardType.numberPad
    
    public init() {}
    
    public func isValid(_ text: String) -> Bool {
        return UalaValidator().isValid(cbuString: text)
    }
}

public class AliasRule: CURule {
    
    public var limit = UalaValidator.aliasMaxLimit
    public var keyboard = UIKeyboardType.default
    
    public init() {}
    
    public func isValid(_ text: String) -> Bool {        
        return UalaValidator().isValid(cuAlias: text)
    }
}
