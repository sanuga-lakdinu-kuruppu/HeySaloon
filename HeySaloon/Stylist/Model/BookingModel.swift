import SwiftUI

struct BookingModel: Codable {
    let bookingId: Int
    let userId: Int
    let stylistId: Int
    let bookingTime: String
    let queuedAt: Int
    let serviceAt: String
    let serviceTime: Int
    let bookingStatus: String
    let selectedServices: [ServiceModel]
    let serviceTotal: Double
}
