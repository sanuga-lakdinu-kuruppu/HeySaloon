import SwiftUI

struct BookingRequest: Codable {
    let stylistId: String
    let clientId: String
    let servicesSelected: [String]
}
