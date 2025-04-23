import SwiftUI

struct FavoriteStylistsResponse: Codable {
    let message: String
    let data: [StylistModel]
}
