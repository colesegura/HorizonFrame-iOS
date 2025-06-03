import Foundation

public struct Insight: Identifiable, Codable, Hashable {
    public let id: UUID
    public let text: String
    public let timestamp: Date
    
    public init(text: String, id: UUID = UUID(), timestamp: Date = Date()) {
        self.id = id
        self.text = text
        self.timestamp = timestamp
    }
}
