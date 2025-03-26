import SwiftUI

struct EmailOtpVerifyRequest: Codable {
    let email: String
    let type: String
    let otp: String
}
