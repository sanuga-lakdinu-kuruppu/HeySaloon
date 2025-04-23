import SwiftUI

struct StylistModel: Codable {
    var stylistId: String
    var createdAt: String?
    var firstName: String
    var lastName: String
    var profileUrl: String
    var thumbnailUrl: String
    var saloonName: String?
    var isOpen: Bool?
    var distance: Double?
    var isClientLiked: Bool?
    var startTime: String?
    var endTime: String?
    var location: Location?
    var address: Address?
    var services: [ServiceModel]?
    var totalQueued: Int?
    var queueWillEnd: String?
    var totalReviewed: Int?
    var currentRating: Double?
}

struct Address: Codable {
    var no: String?
    var address1: String?
    var address2: String?
    var address3: String?
}

struct Location: Codable, Equatable {
    var coordinates: [Double]?
}
