import SwiftUI

struct FuctionButtonView: View {

    var icon: String
    var text: String
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        VStack {

            VStack {
                Image(
                    systemName:
                        icon
                )
                .frame(
                    width: screenwidth * 0.07,
                    height: screenwidth * 0.07
                )
                .padding(screenwidth * 0.02)
            }
            .foregroundColor(Color("MainBackgroundColor"))
            .frame(
                width: ((screenwidth - screenwidth * 0.1) - (screenwidth * 0.08))
                    / 4
            )
            .background(.white)
            .cornerRadius(screenwidth * 0.04)

            CaptionTextView(text: text)
        }
    }
}

#Preview {
    FuctionButtonView(icon: "xmark", text: "fjadk")
}
