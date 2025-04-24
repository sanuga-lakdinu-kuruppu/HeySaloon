import SwiftUI
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    //to request permissions for push notifications
    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: options
        ) { _, _ in }
    }

    //to send instant local notifications
    func sendInstantNotifcation(
        title: String,
        body: String,
        isInstant: Bool = false
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: isInstant ? 1 : 5,
            repeats: false
        )

        UNUserNotificationCenter.current().add(
            UNNotificationRequest(
                identifier: "InstantNotification",
                content: content,
                trigger: trigger
            ),
            withCompletionHandler: nil
        )
    }
}
