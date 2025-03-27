import SwiftUI

struct StylistModel: Codable {
    var _id: String
    var firstName: String
    var lastName: String
    var thumbnailUrl: String
    var imageUrl: String
    var saloonName: String
    var saloonLat: Double
    var saloonLog: Double
    var rating: Double
    var totalRating: Int
    var isOpen: Bool
    var start: String
    var end: String
    var totalQueued: Int
    var finishedAt: String
}
