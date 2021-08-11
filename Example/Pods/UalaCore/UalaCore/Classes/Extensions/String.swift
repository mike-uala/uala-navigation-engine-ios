import Foundation

public extension String {
    // remove first letter
    func chopPrefix(_ quantity: Int = 1) -> String {
        if quantity >= 0 && quantity <= self.count {
            return self.substring(from: String.Index(encodedOffset: quantity))
        }
        return ""
    }
    
    // remove last letter
    func chopSuffix(_ quantity: Int = 1) -> String {
        if quantity >= 0 && quantity <= self.count {
            return self.substring(to: String.Index(encodedOffset: self.count - quantity))
        }
        return ""
    }
    
    func replacingOccurrences(ofStrings: [String], with: String) -> String {
        var newStr = self
        for str in ofStrings {
            newStr = newStr.replacingOccurrences(of: str, with: with)
        }
        return newStr
    }
}

public extension String {
    // SUBSTRINGS
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with range: Range<Int>) -> String {
        let startIndex = index(from: range.lowerBound)
        let endIndex = index(from: range.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

//MARK: - Obtain string by index
public extension String {
    var length: Int {
        return count
    }
    
    subscript (index: Int) -> String {
        return self[index ..< index + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (rng: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, rng.lowerBound)),
                                            upper: min(length, max(0, rng.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

extension String {
    func notNullString() -> String? {
        return isEmpty ? nil : self
    }
}

public extension String {
  func indexInt(of char: Character) -> Int? {
    return firstIndex(of: char)?.utf16Offset(in: self)
  }
}

public extension String {
    // check if the string has just numbers
    func isValidNumber() -> Bool {
        let regEx = "^[0-9]*$"
        let cbuCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return cbuCheck.evaluate(with: self)
    }
}
