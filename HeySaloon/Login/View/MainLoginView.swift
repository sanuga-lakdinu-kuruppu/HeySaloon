import SwiftUI

struct MainLoginView: View {

    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var isShowingBottomSheet: Bool = true
    let tag: String =
        "Easiest way of locating near by stylists. Locate, Book and try the online booking experience of walking clients."

    var body: some View {
        ZStack {
            MainBackgroundView()
            VStack {
                Image("Logo")
                    .padding(
                        .top, screenHeight * 0.15)
                Spacer()
            }

        }
        .onAppear {
            showBottomSheetAfterDelay()
        }
        .sheet(isPresented: $isShowingBottomSheet) {
            VStack(spacing: 16) {
                HStack {
                    LargeTitleTextView(text: "Get Started")
                    Spacer()
                }
                .padding(.top, 32)

                CaptionTextView(text: tag)

                //login button group
                Button {
                    print("google btn")
                } label: {
                    MainButtonView(
                        text: "Continue With Google",
                        foregroundColor: Color.black,
                        backgroundColor: Color.white,
                        isBoarder: false,
                        icon: "g.circle.fill"
                    )
                }

                Button {
                    print("mobile btn")
                } label: {
                    MainButtonView(
                        text: "Continue With Mobile Number",
                        foregroundColor: Color.white,
                        backgroundColor: Color(
                            "SecondaryBackgroundColor"
                        ),
                        isBoarder: true,
                        icon: "iphone.gen2"
                    )
                }

                Button {
                    print("email btn")
                } label: {
                    MainButtonView(
                        text: "Continue With Email Address",
                        foregroundColor: Color.white,
                        backgroundColor: Color(
                            "SecondaryBackgroundColor"
                        ),
                        isBoarder: true,
                        icon: "paperplane.fill"
                    )
                }

                //stylist registration
                HyberLinkTextView(text: "Need to be a stylist?")
                    .padding(.top, 8)
                    .onTapGesture {
                        print("stylist register btn")
                    }

                Spacer()
            }
            .padding(.horizontal, screenwidth * 0.05)
            .presentationDetents([.medium, .large])
            .presentationCornerRadius(50)
            .presentationBackground(Color("SecondaryBackgroundColor"))
            .interactiveDismissDisabled(true)
            .presentationDragIndicator(.hidden)
        }
    }

    //delay 0.5s the bottom sheet showing after showing the main screen
    private func showBottomSheetAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isShowingBottomSheet = true
        }
    }

}

#Preview {
    MainLoginView()
}
