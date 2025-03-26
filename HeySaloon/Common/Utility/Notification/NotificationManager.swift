import SwiftUI
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: options
        ) { _, _ in }
    }

    func sendInstantNotifcation(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5, repeats: false)

        UNUserNotificationCenter.current().add(
            UNNotificationRequest(
                identifier: "InstantNotification", content: content,
                trigger: trigger),
            withCompletionHandler: nil
        )
    }
}
