import SwiftUI

struct MainLoginButtonSheetView: View {

    @Binding var isShowingBottomSheet: Bool
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    let tag: String =
        "Easiest way of locating near by stylists. Locate, Book and try the online booking experience of walking clients."

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                LargeTitleTextView(text: "Get Started")
                Spacer()
            }
            .padding(.top, 32)

            HStack {
                CaptionTextView(text: tag)
                Spacer()
            }

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
                navigateToEmailLogin()
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

    //to navigate to the email login
    private func navigateToEmailLogin() {
        dismissBottomSheet()
        CommonGround.shared.routes
            .append(
                Route.emailLogin
            )
    }

    //to close the bottom sheet
    private func dismissBottomSheet() {
        isShowingBottomSheet = false
    }
}

#Preview {
    //    MainLoginButtonSheetView()
}
