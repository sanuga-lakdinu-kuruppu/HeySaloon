import SwiftUI

struct PortfolioResponse: Decodable {
    let message: String
    let data: [PortfolioModel]
}
