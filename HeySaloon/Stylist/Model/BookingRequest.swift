import SwiftUI

struct BookingRequest: Codable {
    let stylistId: Int
    let selectedServices: [ServiceModel]
}
