import SwiftUI

struct ErrorMessageTextView: View {

    var text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(Color("ErrorColor"))
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityLabel(text)
    }
}

#Preview {
    ErrorMessageTextView(text: "fsdkla")
}
