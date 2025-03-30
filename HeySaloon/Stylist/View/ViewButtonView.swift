import SwiftUI

struct ViewButtonView: View {

    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        Text("View")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(
                Color("MainBackgroundColor")
            )
            .padding(.vertical, screenwidth * 0.02)
            .padding(.horizontal, screenwidth * 0.04)
            .background(.accent)
            .cornerRadius(50)
            .accessibilityLabel("View")
            .accessibilityHint("Tap to view")
            .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    ViewButtonView()
}
