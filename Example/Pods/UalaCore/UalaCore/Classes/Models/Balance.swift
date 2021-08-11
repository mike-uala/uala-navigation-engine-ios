//
//  Balance.swift
//  Uala
//
//  Created by Hasael Oliveros on 7/25/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Balance {
    public let accountId: String
    public let availableBalance: Double
    public var balanceData: String
    
    init(
        accountId: String,
        availableBalance: Double
    ) {
        self.accountId = accountId
        self.availableBalance = availableBalance
        self.balanceData = availableBalance == 0
            ? "0"
            : availableBalance > 0 ? ">0" : "<0"
        
    }
}

public class BalanceMapper {
    
    public static func map(from json: JSON) -> Balance {
        
        return Balance(
            accountId: json["accountId"].stringValue,
            availableBalance: Double(json["availableBalance"].stringValue) ?? 0.0
        )
    }
}
