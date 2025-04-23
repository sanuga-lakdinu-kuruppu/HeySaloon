import SwiftUI

struct NearByStylistsResponse: Codable {
    let message: String
    let data: [StylistModel]
}
