import Foundation

extension Date {
    func formattedAsTodayString() -> String {
        let calendar = Calendar.current
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"

        if calendar.isDateInToday(self) {
            return "Today, \(timeFormatter.string(from: self))"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday, \(timeFormatter.string(from: self))"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, hh:mm a"
            return dateFormatter.string(from: self)
        }
    }
}
