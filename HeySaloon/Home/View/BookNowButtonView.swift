import SwiftUI

struct BookNowButtonView: View {
    var body: some View {
        Text("Book Now")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(
                Color("MainBackgroundColor")
            )
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(.white)
            .cornerRadius(50)
            .accessibilityLabel("Book Now")
            .accessibilityHint("Tap to continue")
            .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    BookNowButtonView()
}
