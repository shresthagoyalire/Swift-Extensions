//
//  Date+Extension.swift

import Foundation
extension Date {
    // convert time string to date object
    static func convertTimeStringToDate(string: String?, timeFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
        return formatter.date(from: string ?? "")
    }
    // get time String from date using time format
    func convertToDisplayString(timeFormat: String = "dd MMM yyyy") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
        return formatter.string(from: self)
    }
    // get current time in Miliseconds
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
