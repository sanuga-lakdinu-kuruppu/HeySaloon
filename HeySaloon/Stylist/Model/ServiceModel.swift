import SwiftUI

struct ServiceModel: Identifiable, Codable {
    var id: Int
    var name: String
    var price: Double
    var minutes: Int
}
