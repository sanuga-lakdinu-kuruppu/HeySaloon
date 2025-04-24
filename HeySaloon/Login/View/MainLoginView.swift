import SwiftUI

struct MainLoginView: View {

    @ObservedObject var commonGround: CommonGround
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var isShowingBottomSheet: Bool = false
    @State var isShowingFaceIdSheet: Bool = false
    @State var offSet: CGFloat = 0
    @State var scale: CGFloat = 1.0
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
            MainLoginButtonSheetView(
                isShowingBottomSheet: $isShowingBottomSheet
            )
        }
        .sheet(isPresented: $isShowingFaceIdSheet) {
            FaceIdSheetView(
                faceIDManager: faceIDManager,
                onAuthenticated: {
                    showBottomSheetAfterDelay()
                }
            )
        }
        .navigationBarBackButtonHidden(true)

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

}

#Preview {
    MainLoginView(commonGround: CommonGround.shared)
}
