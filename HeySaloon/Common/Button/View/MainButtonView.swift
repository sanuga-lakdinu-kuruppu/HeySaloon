import SwiftUI

struct MainButtonView: View {

    var text: String
    var foregroundColor: Color
    var backgroundColor: Color
    var isBoarder: Bool
    var icon: String = ""

    var body: some View {
        HStack {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(foregroundColor)
                    .frame(
                        width: UIScreen.main.bounds.width * 0.05,
                        height: UIScreen.main.bounds.width * 0.05
                    )
                    .padding(.trailing, 8)
            }
            Text(text)
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(foregroundColor)
                .accessibilityLabel(text)
                .accessibilityHint("Tap to continue")
                .accessibilityAddTraits(.isButton)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(50)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(
                    isBoarder ? Color("borderLineColor") : Color.clear,
                    lineWidth: 2
                )
        )
    }
}

#Preview {
    MainButtonView(
        text: "Continue With Mobile",
        foregroundColor: Color.white,
        backgroundColor: Color(
            "SecondaryBackgroundColor"
        ),
        isBoarder: true,
        icon: "iphone.gen2"
    )
}
