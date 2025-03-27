import SwiftUI

@main
struct HeySaloonApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var commonGround = CommonGround.shared

    init() {
        NotificationManager.shared.requestPermission()
    }

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
                        } else if destination == Route.commonTab {
                            CommonTabView(commonGround: commonGround)
                        }

                    }
            }
            .accentColor(Color.white)

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate,
    UNUserNotificationCenterDelegate
{
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (
            UNNotificationPresentationOptions
        ) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
