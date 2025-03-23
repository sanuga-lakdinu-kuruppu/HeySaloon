import SwiftUI

struct CaptionTextView: View {

    var text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(Color.white)
            .accessibilityLabel(text)
    }
}

#Preview {
    CaptionTextView(text: " kjfdsla")
}
