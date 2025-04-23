import SwiftUI

struct MainLoginView: View {

    @ObservedObject var commonGround: CommonGround
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var isShowingBottomSheet: Bool = false
    @State var isShowingFaceIdSheet: Bool = false
    @State var offSet: CGFloat = 0
    @State var scale: CGFloat = 1.0
    let tag: String =
        "Easiest way of locating near by stylists. Locate, Book and try the online booking experience of walking clients."
    @StateObject var faceIDManager = FaceIDManager()

    var body: some View {
        ZStack {
            MainBackgroundView()
            VStack {
                Image("Logo")
                    .padding(
                        .top,
                        offSet
                    )
                    .scaleEffect(scale)
                Spacer()
            }

        }
        .onAppear {
            showBottomSheetAfterDelay()
        }
        .onDisappear {
            commonGround.commingFrom = Route.mainLogin
        }
        .sheet(isPresented: $isShowingBottomSheet) {
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
        .sheet(isPresented: $isShowingFaceIdSheet) {
            VStack {

                VStack(spacing: screenwidth * 0.04) {
                    TitleTextView(text: "App Locked")
                    CaptionTextView(text: "Unlock with Face ID")
                }
                .padding(.top, screenwidth * 0.08)

                Spacer()

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

                Button {
                    faceIDManager.authenticate()
                    showBottomSheetAfterDelay()
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
                showBottomSheetAfterDelay()
            }
            .padding(.horizontal, screenwidth * 0.05)
            .presentationDetents([.fraction(0.6)])
            .presentationCornerRadius(50)
            .presentationBackground(Color("SecondaryBackgroundColor"))
            .interactiveDismissDisabled(true)
            .presentationDragIndicator(.hidden)
        }
        .navigationBarBackButtonHidden(true)

    }

    //to navigate to the email login
    private func navigateToEmailLogin() {
        dismissBottomSheet()
        commonGround.routes
            .append(
                Route.emailLogin
            )
    }

    //delay 1.5s the bottom sheet showing after showing the main screen
    private func showBottomSheetAfterDelay() {

        commonGround.getUserDefaults()
        if commonGround.commingFrom == Route.mainApp {
            offSet = screenHeight * 0.3
            scale = 1.3

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if commonGround.isLoggedIn {
                    //already logged in
                    if faceIDManager.isAuthenticated {
                        isShowingFaceIdSheet = false
                        commonGround.routes
                            .append(
                                Route.commonTab
                            )
                    } else {
                        isShowingFaceIdSheet = true
                    }

                } else {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        offSet = screenHeight * 0.15
                        scale = 1.0
                    }
                    isShowingBottomSheet = true
                }

            }
        } else {
            isShowingBottomSheet = true
            offSet = screenHeight * 0.15
            scale = 1.0
        }
    }

    //to close the bottom sheet
    private func dismissBottomSheet() {
        isShowingBottomSheet = false
    }

}

#Preview {
    MainLoginView(commonGround: CommonGround.shared)
}
