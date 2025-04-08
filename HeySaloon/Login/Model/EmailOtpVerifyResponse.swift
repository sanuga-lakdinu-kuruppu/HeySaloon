import SwiftUI

struct EmailOtpVerifyResponse: Codable {
    let status: String
    let message: String
    let data: TokenData?
}

struct TokenData: Codable {
    let accessToken: String?
    let refreshToken: String?
    let idToken: String?
    let role: Role?
    let firstName: String?
    let lastName: String?
    let imageUrl: String?
}
