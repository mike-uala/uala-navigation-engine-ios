//
//  String.swift
//  Uala
//
//  Created by Nelson Domínguez on 14/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UalaCore

public extension String {
        
    var numbers: String {
        return self.reduce("") { (text, character) -> String in
            guard character.isDigit else { return text }
            return "\(text)\(character)"
        }
    }
    
    func withMask(mask: String) -> String {
        var resultString = String()
        
        var stringIndex = self.startIndex
        var maskIndex = mask.startIndex
        
        while stringIndex < self.endIndex && maskIndex < mask.endIndex {
            if mask[maskIndex] == "#" {
                resultString.append(self[stringIndex])
                stringIndex = self.index(after: stringIndex)
            } else {
                resultString.append(mask[maskIndex])
            }
            maskIndex = mask.index(after: maskIndex)
        }
        
        return resultString
    }
    
    func mask(unmaskedIndexList indexList: [Int] = [0]) -> String {
       return String(self.enumerated().map { index, char in
          return indexList.contains(index) ? char : "*"
       })
    }
    
    var milisecondsToDate: Date?{
        if let value = Double(self) {
            return Date(timeIntervalSince1970: TimeInterval(Int64(value) / 1000))
        } else if let dateFromString = Date.fromBancarString(strDate: self) {
            return dateFromString
        }
        
        return nil
    }
    
    var toDate: Date? {
        guard !isEmpty else { return nil }
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //Handle argentina timezone changes
        return dateFormatter.date(from: self)
    }
    
    var toDateHandleTimeZone: Date? {
        guard !isEmpty else { return nil }
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        //Handle argentina timezone changes
        return dateFormatter.date(from: self + " 10:00")
    }
    
    // To Bancar SDK API format e.g: 2012-04-23T18:25:43.511Z
    static func strBancarDate(from date: Date?) -> String {
        guard let _: Date = date else {
            return ""
        }
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return formatter.string(from: date!)
    }
    
    // UI Short Date format dd MMMM e.g: 31 May
    static func strShortDate(from date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        
        return formatter.string(from: date)
    }
    
    static func strShortDateMothAndDate(from date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        
        return formatter.string(from: date)
    }
    
    // UI Short Date format dd/MM
    static func strShortestDate(from date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        
        return formatter.string(from: date)
    }
    
    static func strFullShortestDate(from date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
    
    static func strFullDateAndTime(from date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd 'de' MMMM yyyy - HH:mm"
        formatter.locale = NSLocale(localeIdentifier: EnvironmentHelper().localeIdentifier) as Locale

        return formatter.string(from: date) + "hs"
    }
    
    static func strTime(from date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        
        let dateFormat = DateFormatter.dateFormat (fromTemplate: "j",options:0, locale: Locale.current)!
        
        if dateFormat.contains("a") {
            // 12 hour format.
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        }else {
            // 24 hour format.
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date) + "hs"
        }
    }
    
    static func strMonthAndYear(from date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        return formatter.string(from: date)
    }
    
     func toDateWith(format: String) -> Date {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.date(from: self) ?? Date()
    }
    
    // Currency
    static func strCurrency(from amount: Double, _ digits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: EnvironmentHelper().localeIdentifier) as Locale
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = digits
        formatter.minimumFractionDigits = digits
        
        guard let strAmount = formatter.string(from: NSNumber(value: amount)) else {
            return "$0,0"
        }
        
        return strAmount.removingWhitespaces()
    }
    
    static func strAmount(from amount: Double) -> String {
        let newAmount = amount < 0
            ? amount * -1
            : amount
        let strAmount = String.strCurrency(from: newAmount)
        return amount >= 0 ? "+\(strAmount)" : strAmount
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func removeCurrency() -> String {
        return self.replacingOccurrences(ofStrings: ["$"], with: "")
    }
}

// MARK: String Helper
public extension String {
    func shortString() -> String {
        let displayString = NSMutableString.init()
        var words = components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        
        if !words.isEmpty {
            let firstWord = words[0]
            if !firstWord.isEmpty {
                let index = firstWord.index(firstWord.startIndex, offsetBy: 1)
                displayString.append(firstWord.substring(to: index))
            }
        }
        
        if words.count > 1 {
            var lastWord = words.last
            if  let isWordEmpty = lastWord?.isEmpty {
                while isWordEmpty && words.count > 1 {
                    words.removeLast()
                    lastWord = words.last
                }
            }
            if words.count > 1, let last = lastWord, !last.isEmpty {
                let index = last.index(last.startIndex, offsetBy: 1)
                displayString.append(last.substring(to: index))
            }
        }
        return displayString.uppercased as String
    }
}

public extension Character {
    
    var isDigit: Bool {
        let unicodeScalars = String(self).unicodeScalars
        let unicodeScalarView = unicodeScalars[unicodeScalars.startIndex]
        let digits = CharacterSet.decimalDigits
        return digits.contains(unicodeScalarView)
    }
}

// Used in Salesforce pre-chat fields convertion
public extension String {
    
    /// Only works when the date string had `dd/MM/yyyy` format
    /// - Parameter format: `String` format'
    /// - Returns: `String` or `nil`
    func toDateStringWith(format: String) -> String? {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale =  Locale(identifier: EnvironmentHelper().localeIdentifier)
        formatter.dateFormat = "dd/MM/yyyy"
        guard let date = formatter.date(from: self) else { return  nil }
        return date.toStringWith(format: format)
    }
    
    /// Convert Unix timestamp to the date string in specific format
    /// - Parameter format: `String` format'
    /// - Returns: `String` or `nil`
    mutating func unixToDateString(with format: String) -> String? {
        let timeInterval = (self as NSString).doubleValue / 1000.0
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}

public extension String {
    var attributedRegularString: NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        return NSAttributedString(string: self,
                                  attributes: [.font: UIFont.regular(size: 15),
                                               .foregroundColor: UalaStyle.colors.grey50,
                                               .paragraphStyle: style])
        
    }
    
    var attributedLightString: NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        return NSAttributedString(string: self,
                                  attributes: [.font: UIFont.light(size: 25),
                                               .foregroundColor: UalaStyle.colors.grey70,
                                               .paragraphStyle: style])
        
    }
    
    func attributedString(with color: UIColor) -> NSAttributedString {
        
        return NSAttributedString(string: self,
                                  attributes: [.foregroundColor: color])
    }
    
    var isNull: Bool {
        if self.isEmpty || self == "null" {
            return true
        }
        return false
    }
    
    func notNullString() -> String? {
        return isEmpty ? nil : self
    }
    
}

public extension String {
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        
        return addingPercentEncoding(withAllowedCharacters: allowed)
    }
    
    func replaceNewLines() -> String {
        let string = self.replacingOccurrences(ofStrings: ["\n", "\t", "\\"], with: " ")
        return string
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func isNotNull() -> String? {
        if !self.isNull {
            return self
        }
        return nil
    }
    
    func removePhoneSpecialCharacters() -> String {
        return self.components(separatedBy: .whitespaces).joined().replacingOccurrences(ofStrings: [" ", "(", ")", "-"], with: "")
    }
    
    func formatBasicPhone() -> String {
        
        let basicPhone = self.removePhoneSpecialCharacters()
        
        return "+549\(basicPhone.count > 10 ? basicPhone.substring(from:basicPhone.index(basicPhone.endIndex, offsetBy: -10)) : basicPhone)"
    }
    
    func addSpacing() -> String {
        return self.replacingOccurrences(of: ",", with: ", ")
    }
    
    func doubleDigitString() -> String? {
        return String(format: "%02d", count)
    }
    
    func singleDigitString() -> String? {
        guard let int = Int(self) else { return nil }
        return String(format: "%03d", int)
    }
}

public extension String {
    var html2AttStr: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html,
                                                                   .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
    
    func replaceHTMLTag(tag: String, withAttributes attributes: [NSAttributedString.Key : Any]) -> NSMutableAttributedString {
        let openTag = "<\(tag)>"
        let closeTag = "</\(tag)>"
        let resultingText = NSMutableAttributedString(string: self)
        while true {
            let plainString = resultingText.string as NSString
            let openTagRange = plainString.range(of: openTag)
            if openTagRange.length == 0 {
                break
            }
            
            let affectedLocation = openTagRange.location + openTagRange.length
            let searchRange = NSMakeRange(affectedLocation, plainString.length - affectedLocation)
            
            let closeTagRange = plainString.range(of: closeTag, options: NSString.CompareOptions(rawValue: 0), range: searchRange)
            
            resultingText.addAttributes(attributes, range: NSMakeRange(affectedLocation, closeTagRange.location - affectedLocation))
            resultingText.deleteCharacters(in: closeTagRange)
            resultingText.deleteCharacters(in: openTagRange)
        }
        return resultingText
    }
    
    var faqString: NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        let text = self.replaceHTMLTag(tag: "a", withAttributes: [.font: UIFont.regular(size: 20), .foregroundColor: UIColor.black, .paragraphStyle: style])
        text.replaceHTMLTag(tag: "p", withAttributes: [.font: UIFont.regular(size: 16), .foregroundColor: UalaStyle.colors.grey70])
        text.replaceHTMLTag(tag: "b", withAttributes: [.font: UIFont.bold(size: 16)])
        return text
    }
    
    func firstRange(of characters: Int) -> String {
        return self.substring(to: self.index(self.startIndex, offsetBy: characters))
    }
}

public extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

public extension NSMutableAttributedString {
    func replaceHTMLTag(tag: String, withAttributes attributes: [NSAttributedString.Key : Any]) {
        let openTag = "<\(tag)>"
        let closeTag = "</\(tag)>"
        while true {
            let plainString = self.string as NSString
            let openTagRange = plainString.range(of: openTag)
            if openTagRange.length == 0 {
                break
            }
            
            let affectedLocation = openTagRange.location + openTagRange.length
            
            let searchRange = NSMakeRange(affectedLocation, plainString.length - affectedLocation)
            
            let closeTagRange = plainString.range(of: closeTag, options: NSString.CompareOptions(rawValue: 0), range: searchRange)
            
            self.addAttributes(attributes, range: NSMakeRange(affectedLocation, closeTagRange.location - affectedLocation))
            self.deleteCharacters(in: closeTagRange)
            self.deleteCharacters(in: openTagRange)
        }
    }
}

public extension String {
    
    // obtain string before or after special character
    func needle(needle: String, beforeNeedle: Bool = false) -> String? {
        guard let range = self.range(of: needle) else { return nil }
        
        if beforeNeedle {
            return self.substring(to: range.lowerBound)
        }
        
        return self.substring(from: range.upperBound)
    }
    
    // formatting text for currency textField
  func currencyInputFormatting(minFractionDigits: Int? = nil, maxFractionDigits: Int? = nil) -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: EnvironmentHelper().localeIdentifier) as Locale
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = maxFractionDigits ?? 2
        formatter.minimumFractionDigits = minFractionDigits ?? 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        let ratio = maxFractionDigits.isNull ? Double(100) : pow(Double(10), Double(maxFractionDigits ?? 0))
        number = NSNumber(value: (double / ratio))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    func removeSpaces() -> String {
        return self.replacingOccurrences(ofStrings: [" "], with: "")
    }
    
    func convertCurrencyToDouble(minFractionDigits: Int? = nil, maxFractionDigits: Int? = nil) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: EnvironmentHelper().localeIdentifier) as Locale
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = maxFractionDigits ?? 2
        formatter.minimumFractionDigits = minFractionDigits ?? 2
        
        let amountWithPrefix = self
        
        if let number = formatter.number(from: amountWithPrefix) {
            return number.doubleValue
        }
        
        return nil
    }
    
    static func strDecimalWithComma(number: Double) -> String {
        return "\(number)".replacingOccurrences(ofStrings: ["."], with: ",")
    }
}

public extension String {
    
    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
        let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
    }
}

extension String {
    func withBoldText(boldPartsOfString: [String], font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
}

/// Use the following extension to format the phone number to the text strings
public extension String {

    func format(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for character in mask where index < numbers.endIndex {
            if character == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(character)
            }
        }
        return result
    }
}

public extension String {
    func percentageInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent

        var valueWithPrefix = self

        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        valueWithPrefix = regex.stringByReplacingMatches(in: valueWithPrefix,options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (valueWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        guard number != 0 as NSNumber else { return "" }

        return formatter.string(from: number)!
      }
}
