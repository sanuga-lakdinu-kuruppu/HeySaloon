import SwiftUI

struct HairCutButtonView: View {

    var model: ArModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            Image(model.imageName)
                .resizable()
                .frame(
                    width: screenwidth * 0.14,
                    height: screenwidth * 0.14
                )
                .opacity(model.isPro ? 0.3 : 1)
                .cornerRadius(screenwidth * 0.04)
            if model.isPro {
                VStack {
                    CaptionTextView(
                        text: "Pro",
                        foregroundColor:
                            .mainBackground,
                        fontWeight: .bold
                    )
                }
            }
        }
    }
}

#Preview {
    //    HairCutButtonView()
}
