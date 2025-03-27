import SwiftUI

struct HeadlineTextView: View {

    var text: String

    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .accessibilityLabel(text)
    }
}

#Preview {
    HeadlineTextView(text: "dfjsla")
}
