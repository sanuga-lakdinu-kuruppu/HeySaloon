import SwiftUI

@main
struct HeySaloonApp: App {

    @StateObject var commonGround = CommonGround.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $commonGround.routes) {
                MainLoginView(commonGround: commonGround)
                    .navigationDestination(for: Route.self) {
                        destination in

                        //global navigation all around the application
                        if destination == Route.emailLogin {
                            EmailLoginView(commonGround: commonGround)
                        } else if destination == Route.loginOtpVerification {
                            LoginOtpVerificationView(commonGround: commonGround)
                        } else if destination == Route.tabView {
                            TabView()
                        }

                    }
            }
            .accentColor(Color.white)

        }
    }
}
