import SwiftUI

struct BookingCreateResponse: Decodable {
    let message: String
    let data: BookingModel?
}
