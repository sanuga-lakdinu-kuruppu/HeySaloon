import SwiftUI

struct LargeTitleTextView: View {

    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color.white)
            .accessibilityLabel(text)
    }
}

#Preview {
    LargeTitleTextView(text: "Get Started")
}
