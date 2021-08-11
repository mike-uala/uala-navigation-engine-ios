//
//  IgnoreNilExtension.swift
//  UalaUI
//
//  Created by Christian Correa on 18/02/21.
//

import Foundation

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

public extension Optional where Wrapped: Any {
    
    var isNull: Bool {
        return self == nil
    }
    
    func value(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}
