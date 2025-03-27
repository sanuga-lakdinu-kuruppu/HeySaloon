import SwiftUI

struct CalloutTextView: View {

    var text: String
    var foregroundColor: Color = .white

    var body: some View {
        Text(text)
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundColor(foregroundColor)
            .accessibilityLabel(text)
    }
}

#Preview {
    CalloutTextView(text: "this is the callout")
}
