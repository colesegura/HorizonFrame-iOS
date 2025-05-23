import Foundation

public struct Insight: Identifiable, Codable, Hashable {
    public var id = UUID()
    public var text: String
    public var created = Date()
}
