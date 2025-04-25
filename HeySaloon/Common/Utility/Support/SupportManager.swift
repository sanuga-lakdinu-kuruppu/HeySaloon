import SwiftUI

class SupportManager {
    static let shared = SupportManager()
    let refreshTokenUrl =
        "\(CommonGround.shared.baseUrl)/auth/refresh"

    //list of ar models in the appliation running with thier respective config data
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

    //getIcon in map view
    func getIcon(instruction: String) -> String {
        let lowercased = instruction.lowercased()
        if lowercased.contains("left") {
            return "arrow.turn.up.left"
        } else if lowercased.contains("right") {
            return "arrow.turn.up.right"
        } else {
            return "app.connected.to.app.below.fill"
        }
    }

    //jwt token decoding
    func decodeJwt(jwtToken jwt: String) -> [String: Any]? {
        let segments = jwt.components(separatedBy: ".")
        guard segments.count > 1 else { return nil }

        var base64 = segments[1]
        base64 = base64.replacingOccurrences(of: "-", with: "+")
        base64 = base64.replacingOccurrences(of: "_", with: "/")

        let paddingLength = 4 - base64.count % 4
        if paddingLength < 4 {
            base64 += String(repeating: "=", count: paddingLength)
        }

        guard let data = Data(base64Encoded: base64) else {
            print("base64 decoding failed")
            return nil
        }
        let jsonObject = try? JSONSerialization.jsonObject(
            with: data,
            options: []
        )
        return jsonObject as? [String: Any]
    }

    //to get a new access token from the refresh token
    func getNewRefreshToken() async throws {
        let (refreshData, refreshResponse) =
            try await NetworkSupporter.shared.call(
                requestBody: RefreshTokenRequest(
                    refreshToken: CommonGround
                        .shared.refreshToken
                ),
                endpoint: refreshTokenUrl,
                method: "POST",
                isSecured: false
            )

        if refreshResponse.statusCode == 200 {
            let emailOtpVerifyResponse = try JSONDecoder().decode(
                EmailOtpVerifyResponse.self,
                from: refreshData
            )
            CommonGround.shared.accessToken =
                emailOtpVerifyResponse.data.accessToken
            CommonGround.shared.refreshToken =
                emailOtpVerifyResponse.data.refreshToken
            CommonGround.shared.saveUserDefaults()

        } else {
            throw NetworkError.processError
        }
    }

    //to convert date into required format
    func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        let currentDate = date
        return formatter.string(from: currentDate)
    }

    //to convert the ISO string to the desired format but without time
    func convertIOSStringToMyFormatWithoutTime(
        _ isoDateString: String,
        outputFormat: String = "MMM d, yyyy"
    ) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [
            .withInternetDateTime, .withFractionalSeconds,
        ]

        guard let date = isoFormatter.date(from: isoDateString) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale.current
        outputFormatter.timeZone = TimeZone.current

        return outputFormatter.string(from: date)
    }

    //to get the current time in ISO format
    func getCurrentISOTimeString() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        return isoFormatter.string(from: Date())
    }

}
