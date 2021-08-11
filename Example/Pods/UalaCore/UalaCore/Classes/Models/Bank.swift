//
//  Bank.swift
//  Uala
//
//  Created by Hasael Oliveros on 8/11/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Bank: CustomStringConvertible, Equatable {
    
    let code: String
    let name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    
    public var description: String {
        return name
    }
    
    public static func==(lhs: Bank, rhs: Bank) -> Bool {
        return lhs.code == rhs.code
    }
}

public extension Bank {
    
    private static func fromLocalBundle() -> [Bank] {
        let bundle = BundleUtils.getBundle(from: .Core)
        guard let path = bundle.path(forResource: "bankCodes", ofType: "json") else { return [] }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let json = try JSON(data: data)
            return BankMapper().map(from: json.arrayValue)
        } catch _ {
            return []
        }
    }        
    
    static func bankName(for bankCode: String) -> String? {
        let banks = fromLocalBundle()
        return banks.first(where: { $0.code == bankCode })?.name
    }
    
    static func bankName(whit bankCBU: String) -> String? {
        guard bankCBU.count >= 3 else { return nil }
        let cbuBankCode = bankCBU.prefix(3)
        let banks = fromLocalBundle()
        return banks.first(where: { $0.code == cbuBankCode })?.name
    }
}

