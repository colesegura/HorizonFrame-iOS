import SwiftUI

struct PassageDetailView: View {
    let passage: Passage

    @State private var showShareSheet = false
    @State private var shareImage: UIImage? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(passage.title)
                    .font(.title2).bold()
                if let author = passage.author {
                    Text("By \(author)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Text(passage.content)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Passage")
        .navigationBarTitleDisplayMode(.inline)
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