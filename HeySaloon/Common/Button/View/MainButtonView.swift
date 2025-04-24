import SwiftUI

struct MainButtonView: View {

    var text: String
    var foregroundColor: Color
    var backgroundColor: Color
    var isBoarder: Bool
    var icon: String = ""
    var isDisabled: Bool = false

    var body: some View {
        HStack {

            //button icon
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

            //button text
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
                    isBoarder ? Color("BorderLineColor") : Color.clear,
                    lineWidth: 2
                )
        )
        .opacity(isDisabled ? 0.5 : 1)
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
