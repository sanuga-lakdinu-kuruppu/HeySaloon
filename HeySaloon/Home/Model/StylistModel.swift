import SwiftUI

struct StylistModel: Identifiable {
    var id: UUID = UUID()
    var firstname: String
    var lastname: String
    var saloon: String
    var thumbnailUrl: String
    var rating: Double
    var totalRating: Int
    var isOpen: Bool
}
