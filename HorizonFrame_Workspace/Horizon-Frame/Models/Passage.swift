import Foundation
import UIKit

struct Passage: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String
    var content: String
    var author: String?
    var category: String
    var tags: [String]?
    var isActive: Bool = false
    var thumbnailName: String?
    var videoName: String?

    func loadThumbnail() -> UIImage? {
        guard let thumbnailName = thumbnailName else { return nil }
        return UIImage(named: thumbnailName, in: Bundle.main, with: nil)
    }

    func loadVideo() -> URL? {
        guard let videoName = videoName else { return nil }
        return Bundle.main.url(forResource: videoName, withExtension: nil)
    }

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