import SwiftUI

struct TopRatedStylistsResponse: Codable {
    let message: String
    let data: [StylistModel]
}
