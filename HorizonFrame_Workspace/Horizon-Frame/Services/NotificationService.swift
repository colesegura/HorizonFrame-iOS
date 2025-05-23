import UserNotifications

public enum NotificationService {
    static func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    static func schedule(insights: [Insight]) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        guard !insights.isEmpty else { return }
        let interval = 24.0 / Double(insights.count) * 3600     // seconds between notifs

        for (idx, insight) in insights.enumerated() {
            let content = UNMutableNotificationContent()
            content.title = "Insight"
            content.body = insight.text
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval * Double(idx + 1),
                                                             repeats: false)
            let request = UNNotificationRequest(identifier: insight.id.uuidString,
                                                content: content,
                                                trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
}
