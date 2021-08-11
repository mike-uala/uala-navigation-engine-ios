//
//  GlobalFunctions.swift
//  Uala
//
//  Created by Nelson Domínguez on 13/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public enum StringTables: String {
    case Common, Core, Investments, Loans, PinFlow, Transactions, SignUp, Exchange, AccountCharge, Transfers, Acquiring, UalaHelp, Cards, Loyalty, Portfolio
}

public func translate(_ key: String, from table: StringTables? = nil) -> String {
    let bundle = BundleUtils.getBundle(from: table)
    let tableName = table?.rawValue ?? "Localizable"
    let environment: Environment = ServiceLocator.inject()
    let value = NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: "")
        
    return NSLocalizedString(key, tableName: tableName + "-\(environment.id)", bundle: bundle, value: value, comment: "")
}

public func optionalStringValidator(_ text: String?) -> String {
    if let text = text {
        return text
    }
    return ""
}
