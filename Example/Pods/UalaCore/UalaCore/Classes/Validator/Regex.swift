//
//  Regex.swift
//  UalaCore
//
//  Created by Matías Schwalb on 07/07/2021.
//

import Foundation

public class RegexValidator {
    
    /// Validates if the regular expression was found in the given string
    /// - Parameters:
    ///   - value: String to be checked
    ///   - regex: Regex to check in value
    /// - Returns: True if the value conforms to the regular expression, false if it doesn't
    static public func validate(_ value: String, withRegex regex: String) -> Bool {
        let result = value.range(of: regex, options: .regularExpression, range: nil, locale: nil)
        return (result != nil)
    }
}
