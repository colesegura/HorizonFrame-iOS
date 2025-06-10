import SwiftUI

struct CollectionDetailView: View {
    let collection: Collection

    var body: some View {
        List(collection.passages) { passage in
            NavigationLink(destination: PassageDetailView(passage: passage)) {
                VStack(alignment: .leading) {
                    Text(passage.title)
                        .font(.headline)
                    if let author = passage.author {
                        Text(author)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text(passage.snippet)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle(collection.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}