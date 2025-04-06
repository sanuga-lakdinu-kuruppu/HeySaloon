import SwiftUI

struct CommonListItemView: View {

    var title: String
    var value: String
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        VStack(spacing: screenwidth * 0.05) {
            HStack {
                CaptionTextView(
                    text:
                        title,
                    fontWeight: .bold
                )
                Spacer()
                CaptionTextView(
                    text:
                        value,
                    fontWeight: .bold
                )

            }
            CommonDividerView()
        }
        .padding(.top, screenwidth * 0.05)

    }
}

#Preview {
    CommonListItemView(title: "fajlskd", value: "fkasjld")
}
