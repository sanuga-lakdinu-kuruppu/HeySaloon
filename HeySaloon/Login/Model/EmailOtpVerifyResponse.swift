import SwiftUI

struct EmailOtpVerifyResponse: Codable {
    let message: String
    let data: TokenData
}

struct TokenData: Codable {
    let accessToken: String
    let refreshToken: String
}
