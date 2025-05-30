import SwiftUI

struct LargeTitleTextView: View {

    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .accessibilityLabel(text)
    }
}

#Preview {
    LargeTitleTextView(text: "Get Started")
}
