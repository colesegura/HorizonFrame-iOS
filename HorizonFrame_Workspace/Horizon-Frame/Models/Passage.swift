import Foundation

struct Passage: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String
    var content: String
    var author: String?
    var category: String

    // A short snippet for previews or list display
    var snippet: String {
        if content.count <= 100 {
            return content
        } else {
            let prefix = content.prefix(100)
            return String(prefix) + "..."
        }
    }
}