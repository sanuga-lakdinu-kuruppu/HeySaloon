import SwiftUI

struct SignoutConfirmationSheet: View {

    @Binding var isShowSignOutSheet: Bool
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            VStack {

                VStack(spacing: screenwidth * 0.08) {
                    HStack {
                        HeadlineTextView(text: "Sign Out Confirmation")
                    }

                    CaptionTextView(
                        text:
                            "By clicking the following “Yes, Sign Out” button, you will be Sign Out from the account and needs the credentials again to sign in."
                    )

                    VStack {
                        //no need to cancel button
                        Button {
                            isShowSignOutSheet.toggle()
                        } label: {
                            MainButtonView(
                                text: "No Need to Sign Out",
                                foregroundColor: Color.black,
                                backgroundColor: Color.white,
                                isBoarder: false
                            )
                        }

                        //cancel button
                        Button {
                            CommonGround.shared.logout()
                            CommonGround.shared.routes
                                .append(
                                    Route.mainLogin
                                )
                        } label: {
                            MainButtonView(
                                text: "Yes, Sign Out",
                                foregroundColor: Color.white,
                                backgroundColor: Color(
                                    "SecondaryBackgroundColor"
                                ),
                                isBoarder: true
                            )
                        }
                    }

                }
                .padding(.top, screenwidth * 0.08)
                .padding(.horizontal, screenwidth * 0.05)

                Spacer()
            }
            .presentationDetents([.medium])
            .presentationCornerRadius(50)
            .presentationBackground(Color("MainBackgroundColor"))
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    //    SignoutConfirmationSheet()
}
