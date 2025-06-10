import Foundation

struct Session: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String?
    var passage: Passage
    var date: Date?
    var isDailyPractice: Bool = false
    var isCompleted: Bool = false
    var completionDate: Date? = nil
}