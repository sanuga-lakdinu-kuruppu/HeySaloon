import SwiftUI

struct FavoriteStylistsResponse: Codable {
    let status: String
    let message: String
    let data: [StylistModel]
}
