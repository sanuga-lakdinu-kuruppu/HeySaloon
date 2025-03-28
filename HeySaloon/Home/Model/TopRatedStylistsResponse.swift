import SwiftUI

struct TopRatedStylistsResponse: Codable {
    let status: String
    let message: String
    let data: [StylistModel]
}
