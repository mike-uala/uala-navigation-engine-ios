//
//  CUIL.swift
//  Uala
//
//  Created by Nelson Domínguez on 26/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public class CUIL {
    
    public init(){ }
    
    private let multipliers = [5, 4, 3, 2, 7, 6, 5, 4, 3, 2]
    
    func isValid(cuil: String) -> Bool {
        let substring = cuil.substring(to: cuil.index(before: cuil.endIndex))
        guard let expectedDigit = self.checkerDigit(substring: substring) else { return false }
        
        let checkerDigit = cuil[cuil.index(before: cuil.endIndex)]
        return String(checkerDigit) == "\(expectedDigit)"
    }
    
    private func checkerDigit(substring: String) -> Int? {
        
        let digitalCharacters = CharacterSet.decimalDigits.inverted
        if substring.rangeOfCharacter(from: digitalCharacters) != nil {
            return nil
        }
        
        if substring.count != 10 {
            return nil
        }
        
        let numbers = "\(substring)".map { Int(String($0))! }
        
        var total = 0
        for (index, element) in numbers.enumerated() {
            total += element * multipliers[index]
        }
        
        let mod = total % 11
        
        switch mod {
        case 0:
            return mod
        case 1:
            return 9
        default:
            return 11 - mod
        }
    }
    
    public func estimated(prefix: String, document: String) -> String? {
        
        var document = document
        if document.count == 7 {
            document = "0\(document)"
        }
        
        let substring = "\(prefix)\(document)"
        guard let checkerDigit = self.checkerDigit(substring: substring) else { return nil }
        
        if checkerDigit == 9 && prefix != "23" {
            return estimated(prefix: "23", document:document)
        }
        
        return "\(prefix)\(document)\(checkerDigit)"
    }
}
