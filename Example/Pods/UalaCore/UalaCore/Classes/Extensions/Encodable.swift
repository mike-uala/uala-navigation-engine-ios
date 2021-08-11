//
//  Encodable.swift
//  UalaCore
//
//  Created by Fabrizio Sposetti on 24/08/2020.
//

import Foundation


struct JSONEncode {
    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    public var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncode.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
