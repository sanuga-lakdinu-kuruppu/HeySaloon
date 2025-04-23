import SwiftUI

struct PortfolioModel: Codable {
    var portfolioId: String
    var name: String?
    var imageUrl: String?
    var likes: Int?
    var isClientLiked: Bool?
}
