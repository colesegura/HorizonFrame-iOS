import SwiftUI

struct PassageDetailView: View {
    let passage: Passage

    @State private var showShareSheet = false
    @State private var shareImage: UIImage? = nil

    var body: some View {
        ZStack {
            // Video background that fills the entire screen
            // Video background that fills the entire screen
            if let videoName = passage.videoName {
                VideoPlayerView(videoName: videoName)
                    .ignoresSafeArea()
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
                .padding()
                .padding()
                .background(.black.opacity(0.5))
                .cornerRadius(20)
                .padding()
            }
        }
        .navigationTitle("") // Hide title to maximize view
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Generate shareable image of the passage
                    if let image = ShareCardRenderer().renderPassageCard(for: passage) {
                        self.shareImage = image
                        self.showShareSheet = true
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
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