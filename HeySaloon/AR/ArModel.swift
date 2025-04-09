import SwiftUI

struct ArModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let modelName: String
    let imageName: String
    let xValue: Float
    let yValue: Float
    let zValue: Float
    let isPro: Bool
}
