// Services/NotificationService.swift
import UserNotifications

enum NotificationService {
    static func schedule(id: String, title: String, body: String, at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body  = body
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents(
            [.year,.month,.day,.hour,.minute], from: date), repeats: false)

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { err in
            if let err = err { print("Notif error: \(err)") }
        }
    }
}