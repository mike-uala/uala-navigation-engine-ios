import Foundation

public class DateHelper {
    public static func dateFrom(_ date: Any?) -> Date? {
        // Date sometimes comes as milliseconds - workaround
        if let stringDate = date as? String {
            if let value = Double(stringDate) {
                return Date(timeIntervalSince1970: TimeInterval(Int64(value) / 1000))
            } else if let dateFromString = Date.fromBancarString(strDate: stringDate) {
                return dateFromString
            }
        }
        return nil
    }
}
