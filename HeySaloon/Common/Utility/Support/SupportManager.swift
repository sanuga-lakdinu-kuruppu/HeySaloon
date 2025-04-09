import SwiftUI

class SupportManager {
    static let shared = SupportManager()

    let arModelList: [ArModel] = [
        .init(
            name: "Crew Cut",
            modelName: "firstCutOriginal",
            imageName: "imageFirstCutOriginal",
            xValue: 0,
            yValue: -0.02,
            zValue: -0.05,
            isPro: false
        ),
        .init(
            name: "Buzz Cut",
            modelName: "secondCutOriginal",
            imageName: "imageSecondCutOriginal",
            xValue: 0,
            yValue: -0.197,
            zValue: -0.02,
            isPro: false
        ),
        .init(
            name: "O Cut",
            modelName: "secondCutOriginal",
            imageName: "imageSecondCutOriginal",
            xValue: 0,
            yValue: -0.197,
            zValue: -0.02,
            isPro: true
        ),
        .init(
            name: "Wix Cut",
            modelName: "secondCutOriginal",
            imageName: "imageSecondCutOriginal",
            xValue: 0,
            yValue: -0.197,
            zValue: -0.02,
            isPro: true
        ),
        .init(
            name: "Lia Cut",
            modelName: "secondCutOriginal",
            imageName: "imageSecondCutOriginal",
            xValue: 0,
            yValue: -0.197,
            zValue: -0.02,
            isPro: true
        ),
        .init(
            name: "Yoa Cut",
            modelName: "secondCutOriginal",
            imageName: "imageSecondCutOriginal",
            xValue: 0,
            yValue: -0.197,
            zValue: -0.02,
            isPro: true
        ),
    ]

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
