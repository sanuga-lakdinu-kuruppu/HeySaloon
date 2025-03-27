import SwiftUI

struct UserProfileResponse: Codable {
    let status: String
    let message: String
    let data: UserProfileModel?
}
