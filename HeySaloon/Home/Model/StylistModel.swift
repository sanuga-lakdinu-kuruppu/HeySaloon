import SwiftUI

struct StylistModel: Identifiable, Codable {
    var _id: String
    var stylistId: Int
    var firstName: String
    var lastName: String
    var thumbnailUrl: String
    var imageUrl: String
    var saloonName: String
    var location: Location
    var rating: Double
    var totalRating: Int
    var isOpen: Bool
    var start: String
    var end: String
    var totalQueued: Int
    var finishedAt: String
    var services: [ServiceModel]

    var id: String { _id }
}

struct Location: Codable {
    var coordinates: [Double]
}
