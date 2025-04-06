import SwiftUI

class SupportManager {
    static let shared = SupportManager()

    private init() {}

    //to convert the time string to the desired format
    func getFinishTime(finishTime: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime, .withFractionalSeconds,
        ]

        if let date = formatter.date(from: finishTime) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let timeOnly = timeFormatter.string(from: date)
            return timeOnly
        } else {
            return ""
        }
    }

    //to get time difference
    func getTimeDifference(finishTime: String) -> Int {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime, .withFractionalSeconds,
        ]
        if let date = formatter.date(from: finishTime) {
            let currentDate = Date()
            let dif = Int(date.timeIntervalSince(currentDate) / 60)
            return dif
        } else {
            return 0
        }
    }
}
