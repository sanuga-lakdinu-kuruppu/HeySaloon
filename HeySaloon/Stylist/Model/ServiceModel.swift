import SwiftUI

struct ServiceModel: Codable, Equatable {
    var serviceId: String
    var serviceName: String
    var serviceCost: Double
    var serviceWillTake: Int
}
