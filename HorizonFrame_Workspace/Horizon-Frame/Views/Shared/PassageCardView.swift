import SwiftUI

struct PassageCardView: View {
    let passage: Passage
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Image
            if let image = passage.loadThumbnail() {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                // Fallback gradient if no image
                LinearGradient(
                    gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }

            // Dark gradient overlay for text readability
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.0)]),
                startPoint: .bottom,
                endPoint: .center
            )

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(passage.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .shadow(radius: 2)

                if let author = passage.author {
                    Text(author)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(radius: 2)
                }
            }
            .padding()
        }
        .frame(height: 180) // A consistent height for all cards
        .cornerRadius(16)
        .clipped() // Ensures the image doesn't bleed past the rounded corners
        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

struct PassageCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Use the first passage from our dummy data for the preview
        PassageCardView(passage: DummyData.passages[0])
            .padding()
            .background(Color.black)
    }
}
