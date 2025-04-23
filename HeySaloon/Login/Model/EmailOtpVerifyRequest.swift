import SwiftUI

struct EmailOtpVerifyRequest: Codable {
    let loginType: String
    let verificationType: String
    let email: String
    let otp: String
}
