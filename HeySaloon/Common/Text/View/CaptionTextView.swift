import SwiftUI

struct CaptionTextView: View {

    var text: String
    var foregroundColor: Color = .white
    var fontWeight: Font.Weight = .regular

    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(fontWeight)
            .foregroundColor(foregroundColor)
            .frame(alignment: .leading)
            .accessibilityLabel(text)
    }
}

#Preview {
    CaptionTextView(text: " kjfdsla")
}
