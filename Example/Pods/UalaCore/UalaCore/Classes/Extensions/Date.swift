import Foundation

public extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

public enum Days: String {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}

public extension Date {
    
    // From Bancar SDK API format e.g: 2012-04-23T18:25:43.511Z
    static func fromBancarString(strDate: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale.init(identifier:"es_ES")
        
        return formatter.date(from: strDate)
    }
    
    static func fromAndreaniString(strDate: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let date = formatter.date(from: strDate) {
            return date
        }
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return formatter.date(from: strDate)
    }
    
    static func fromString(strDate: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: strDate)
    }
    
    static func fromTabString(strDate: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        return formatter.date(from: strDate)
    }
    
    static func fromLabelString(strDate: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        
        return formatter.date(from: strDate)
    }
    
    static func fromStringHandleTimeZone(strDate: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return formatter.date(from: strDate + " 10:00")
    }
    
    private func formattString(format: String) -> DateFormatter? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter
    }
    
    private func yearsInBetweenDate(date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/31536000)
        return diff
    }
    
    func isBirthDateValid() -> Bool {
        return self.yearsInBetweenDate(date: Date()) >= 14 && self.yearsInBetweenDate(date: Date()) <= 99
    }
    
    func isAdult() -> Bool {
        return self.yearsInBetweenDate(date: Date()) >= 18
    }
    
    func toDayMonthAndYearString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "dd MMMM yyyy"
        
        return formatter.string(from: self)
    }
    
    func toBornDateString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: self)
    }
    
    func toBackEndString() -> String? {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: self)
    }
    
    func toStringWith(format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    func isCurrent(fromDate: Date, toDate: Date) -> Bool {
        return self >= fromDate && self <= toDate
    }
    
    func monthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = self.year < Date().year ? "MMMM YY" : "MMMM"
        let month = formatter.string(from: self)
        guard let first = month.first else { return month }
        
        return String(first).uppercased() + month.dropFirst()
    }
    
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

public extension Date {
    
    var day: Int { return Calendar.current.component(.day, from: self) }
    var month: Int { return Calendar.current.component(.month, from: self) }
    var year: Int { return Calendar.current.component(.year, from: self) }
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var nextYear: Date {
        return (Calendar.current as NSCalendar).date(byAdding: .year, value: 1, to: self, options: [])!
    }
    
    var dateString: String {
        return "\(self.year)-\(self.month)-\(self.day)"
    }
    
    var hundredYearBefore: Date {
        return (Calendar.current as NSCalendar).date(byAdding: .year, value: -100, to: self, options: [])!
    }
    
    //Use negative values to subtract years
    func addingYears(_ years: Int) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .year, value: years, to: self, options: [])!
    }
    
    func dateAt(hours: Int, minutes: Int) -> Date? {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        if let timezone = TimeZone(abbreviation: "ART") {
            calendar.timeZone = timezone
        }
        
        var dateComponents = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: self)
        
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = 0
        
        return calendar.date(from: dateComponents)
    }
    
    func addingMinutes(_ minutes: Int) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .minute, value: minutes, to: self, options: [])!
    }
    
    func timeFrom(date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.hour, .minute, .second], from: date, to: self)
    }
}
