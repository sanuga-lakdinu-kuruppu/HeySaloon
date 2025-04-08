import SwiftUI

struct BookingCreateResponse: Decodable {
    let status: String
    let message: String
    let data: BookingModel?
}
