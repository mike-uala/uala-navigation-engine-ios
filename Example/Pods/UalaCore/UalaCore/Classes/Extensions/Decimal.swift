//
//  Decimal.swift
//  UalaCore
//
//  Created by Fabrizio Sposetti on 28/08/2020.
//

import Foundation

extension Decimal {
    public var count: Int {
        return max(-exponent, 0)
    }
}
