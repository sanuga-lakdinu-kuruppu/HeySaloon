import SwiftUI

struct NearByStylistsResponse: Codable {
    let status: String
    let message: String
    let data: [StylistModel]
}
