//
//  CBU.swift
//  Uala
//
//  Created by Hasael Oliveros on 8/11/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public class CBU {
    
    private let firstSegmentMultipliers = [7, 1, 3, 9, 7, 1, 3]
    private let secondSegmentMultipliers = [3, 9, 7, 1, 3, 9, 7, 1, 3, 9, 7, 1, 3]
    
    public func isValid(cbuNumber: String) -> Bool {
        guard cbuNumber.count == 22 else { return false }
        
        if !cbuNumber.isValidNumber() {
            return false
        }
        
        // Substring 1-7
        let indexToSeven = cbuNumber.index(cbuNumber.startIndex, offsetBy: 7)
        let firstSegment = cbuNumber[..<indexToSeven]
        
        // Validate first verificator
        let firstVerificator = Int(String(cbuNumber[indexToSeven]))
        guard let firstVerificatorChecker = self.digitCheck(substring: String(firstSegment), multipliers: firstSegmentMultipliers) else { return false }
        guard firstVerificator == firstVerificatorChecker else { return false }
        
        // Substring 9-21
        let indexFromNine = cbuNumber.index(cbuNumber.startIndex, offsetBy: 8)
        let secondSegment = cbuNumber[indexFromNine..<cbuNumber.index(before: cbuNumber.endIndex)]
        
        
        // Validate second verificator
        let secondVerificator = Int(String(cbuNumber[cbuNumber.index(before: cbuNumber.endIndex)]))
        guard let secondVerificatorChecker = self.digitCheck(substring: String(secondSegment), multipliers: secondSegmentMultipliers) else { return false }
        return secondVerificator == secondVerificatorChecker
    }
    
    public static func bankCode(cbuCode: String) -> String? {
        guard cbuCode.count >= 3 else { return nil }
        
        if !cbuCode.isValidNumber() {
            return nil
        }
        
        let indexToThree = cbuCode.index(cbuCode.startIndex, offsetBy: 3)
        return String(cbuCode[..<indexToThree])
    }
    
    private func digitCheck(substring: String, multipliers: [Int]) -> Int? {
        
        if substring.count != multipliers.count {
            return nil
        }
        
        let numbers = "\(substring)".map { Int(String($0))! }
        
        var total = 0
        numbers.enumerated().forEach { index, element in
            total += element * multipliers[index]
        }
        
        let mod = total % 10
        let verificator = 10 - mod
        
        return (verificator == 10) ? 0 : verificator
    }
    
    private func segmentCheck(substring: String) -> Bool {
        
        let numbers = "\(substring)".map { Int(String($0))! }
        let total = numbers.reduce(0, { $0 + $1 })
        
        return total > 0
    }
    
    // MARK: - CVU
    public static func isCVU(for originAddress: String?) -> Bool? {
        guard let originCBU = originAddress else { return nil }
        let cvu = originCBU.prefix(3)
        return cvu.count == 3 && cvu == "000"
    }
    
    public static func getBankOrWalletName(for cbu: String?) -> String? {
        guard let cbu = cbu else { return nil }
        guard let isCvu = CBU.isCVU(for: cbu), isCvu else { return Bank.bankName(whit: cbu) }
        return Wallet.walletName(for: cbu)
    }
}
