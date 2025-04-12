import SwiftUI

struct PortfolioModel: Codable {
    var id: Int
    var message: String
    var imageUrl: String
    var likes: [Int]
}
