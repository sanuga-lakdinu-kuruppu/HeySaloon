import SwiftUI

struct BookBookingGetResponse: Decodable {
    var message: String
    var data: [BookingModel]
}
