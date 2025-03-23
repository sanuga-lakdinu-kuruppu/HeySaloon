import SwiftUI

struct HyberLinkTextView: View {

    var text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.bold)
            .underline()
            .foregroundColor(Color.white)
            .accessibilityLabel(text)
            .accessibilityHint("Tap to continue")
            .accessibilityAddTraits(.isLink)
    }
}

#Preview {
    HyberLinkTextView(text: "Need to a stylist?")
}
