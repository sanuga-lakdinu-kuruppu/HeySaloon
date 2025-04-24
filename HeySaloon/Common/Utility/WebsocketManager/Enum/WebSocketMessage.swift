import SwiftUI

struct WebSocketMessage: Decodable {
    let type: String
    let booking: BookingModel?
}
