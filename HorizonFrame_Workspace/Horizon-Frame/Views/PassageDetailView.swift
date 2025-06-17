import SwiftUI

struct PassageDetailView: View {
    let passage: Passage

    @State private var showShareSheet = false
    @State private var shareImage: UIImage? = nil
    @Environment(\.dismiss) var dismiss // Environment variable to dismiss the view

    var body: some View {
        ZStack {
            // Video background that fills the entire screen
            // Video background that fills the entire screen
            if let videoName = passage.videoName {
                VideoPlayerView(videoName: videoName)
                    .ignoresSafeArea()
                    .overlay(
                        Color.black.opacity(0.4) // Adjust opacity as needed for readability
                            .ignoresSafeArea()
                    )
            }

            // Scrollable content on top
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(passage.title)
                        .font(.largeTitle).bold()
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    if let author = passage.author {
                        Text("By \(author)")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 3)
                    }

                    Text(passage.content)
                        .font(.title3)
                        .lineSpacing(8)
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                }
                .padding() // Keep overall padding for the text block
                // Removed .background(.black.opacity(0.5)) and .cornerRadius(20)
                // The outer .padding() might also need adjustment or removal depending on desired text inset
            }
        }
        .navigationTitle("") // Hide title to maximize view
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Generate shareable image of the passage
                    if let image = ShareCardRenderer().renderPassageCard(for: passage) {
                        self.shareImage = image
                        self.showShareSheet = true
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white) // Set icon color to white
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            if let image = shareImage {
                ShareSheet(items: [image])
            }
        }
    }
}