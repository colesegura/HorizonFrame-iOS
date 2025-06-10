import Foundation

struct Collection: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String
    var passages: [Passage]
}