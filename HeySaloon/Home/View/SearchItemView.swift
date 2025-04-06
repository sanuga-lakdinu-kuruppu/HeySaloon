import SwiftUI

struct SearchItemView: View {

    var titleText: String
    var subtitleText: String
    var isThisLocation: Bool = true
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {

        HStack(spacing: 16) {
            VStack {
                Image(
                    systemName: isThisLocation ? "scope" : "clock.fill"
                )
                .resizable()
                .frame(
                    width: screenwidth * 0.06, height: screenwidth * 0.06)
            }
            .foregroundColor(Color("MainBackgroundColor"))
            .frame(width: screenwidth * 0.12, height: screenwidth * 0.12)
            .background(isThisLocation ? .white : .accent)
            .cornerRadius(50)

            VStack(alignment: .leading) {
                CalloutTextView(
                    text:
                        titleText
                )
                CaptionTextView(text: subtitleText)
                CommonDividerView()
                    .padding(.top, 8)
            }
            Spacer()
        }
        .padding(.top, 16)
    }

}

#Preview {
    SearchItemView(
        titleText: "fjadslk",
        subtitleText: "fasjdl",
        isThisLocation: true
    )
}
