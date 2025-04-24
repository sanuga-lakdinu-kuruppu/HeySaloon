import SwiftUI

struct FaceIdSheetView: View {

    @ObservedObject var faceIDManager: FaceIDManager
    var onAuthenticated: () -> Void
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            VStack(spacing: screenwidth * 0.04) {
                TitleTextView(text: "App Locked")
                CaptionTextView(text: "Unlock with Face ID")
            }
            .padding(.top, screenwidth * 0.08)

            Spacer()

            //face id logo
            VStack(spacing: screenwidth * 0.04) {
                Image(systemName: "faceid")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(
                        width: screenwidth * 0.13,
                        height: screenwidth * 0.13
                    )
                CaptionTextView(text: "Face ID")
            }
            .frame(
                width: screenwidth * 0.5,
                height: screenwidth * 0.5
            )
            .background(.hint)
            .cornerRadius(screenwidth * 0.04)

            Spacer()

            //face id use button
            Button {
                faceIDManager.authenticate()
                onAuthenticated()
            } label: {
                MainButtonView(
                    text: "Use Face ID",
                    foregroundColor: Color.black,
                    backgroundColor: Color.white,
                    isBoarder: false
                )
            }
            .padding(.bottom, screenwidth * 0.04)
        }
        .onAppear {
            faceIDManager.authenticate()
            onAuthenticated()
        }
        .padding(.horizontal, screenwidth * 0.05)
        .presentationDetents([.fraction(0.6)])
        .presentationCornerRadius(50)
        .presentationBackground(Color("SecondaryBackgroundColor"))
        .interactiveDismissDisabled(true)
        .presentationDragIndicator(.hidden)
    }
}

#Preview {
    //    FaceIdSheetView()
}
