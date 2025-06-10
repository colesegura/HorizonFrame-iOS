import SwiftUI
import UIKit

class ShareCardRenderer {
    /// Render a passage into a UIImage for sharing.
    @MainActor
    func renderPassageCard(for passage: Passage) -> UIImage? {
        // Create a SwiftUI view for the content of the share card
        let shareView = PassageCardView(passage: passage)

        // Use SwiftUI ImageRenderer (iOS 16+) to render the view to an image
        let renderer = ImageRenderer(content: shareView)
        renderer.scale = UIScreen.main.scale  // use device screen scale for clarity
        return renderer.uiImage
    }
}

// Private SwiftUI view defining the layout/styling of the share card
fileprivate struct PassageCardView: View {
    let passage: Passage

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(passage.title)
                .font(.title3).bold()
            if let author = passage.author {
                Text("- \(author)")
                    .font(.subheadline)
                    .padding(.bottom, 8)
            }
            Text(passage.content)
                .font(.body)
        }
        .padding(16)
        .background(Color(UIColor.systemBackground))
        .foregroundColor(.primary)
        .frame(width: 300, alignment: .leading)
    }
}