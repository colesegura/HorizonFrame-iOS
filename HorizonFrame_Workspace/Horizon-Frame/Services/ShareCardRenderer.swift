import SwiftUI
import UIKit

class ShareCardRenderer {
    /// Render a passage into a UIImage for sharing.
    @MainActor
    func renderPassageCard(for passage: Passage) -> UIImage? {
        // Create a SwiftUI view for the content of the share card, adding a background for rendering
        let shareView = PassageCardView(passage: passage)
            .frame(width: 350, height: 500)
            .background(.white)

        // Use SwiftUI ImageRenderer (iOS 16+) to render the view to an image
        let renderer = ImageRenderer(content: shareView)
        renderer.scale = UIScreen.main.scale  // use device screen scale for clarity
        return renderer.uiImage
    }
}