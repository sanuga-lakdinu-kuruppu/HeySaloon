import SwiftUI

struct StylistModel: Codable {
    var _id: String
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
}

struct Location: Codable {
    var coordinates: [Double]
}
