import SwiftUI

struct TitleTextView: View {

    var text: String

    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(Color.white)
            .accessibilityLabel(text)
    }
}

#Preview {
    TitleTextView(text: "fadslk")
}
