import SwiftUI

struct BookingModel: Codable, Equatable {
    var bookingId: String
    var bookingTime: String
    var status: String
    var servicesSelected: [ServiceModel]
    var queuedAt: Int
    var serviceWillTake: Int
    var estimatedStarting: String
    var serviceTotal: Double
    var stylist: StylistProfile?
}

struct StylistProfile: Codable, Equatable {
    var stylistId: String
    var firstName: String?
    var lastName: String?
    var profileUrl: String?
    var location: Location?
    var saloonName: String?
    var totalReviewed: Int?
    var currentRating: Double?
}
