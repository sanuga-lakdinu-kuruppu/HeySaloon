import SwiftUI

struct GradientColorView: View {
    var body: some View {
        LinearGradient(
            colors: [.accent, .accent.opacity(0)],
            startPoint: .bottom,
            endPoint: .top
        )
    }
}

#Preview {
    GradientColorView()
}
