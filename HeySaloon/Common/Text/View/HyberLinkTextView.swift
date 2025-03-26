import SwiftUI

struct HyberLinkTextView: View {

    var text: String
    var foregroundColor: Color = .white

    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.bold)
            .underline()
            .foregroundColor(foregroundColor)
            .accessibilityLabel(text)
            .accessibilityHint("Tap to continue")
            .accessibilityAddTraits(.isLink)
    }
}

#Preview {
    HyberLinkTextView(text: "Need to a stylist?")
}
