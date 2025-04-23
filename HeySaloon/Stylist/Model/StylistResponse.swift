import SwiftUI

struct StylistResponse: Decodable {
    let message: String
    let data: StylistModel?
}
