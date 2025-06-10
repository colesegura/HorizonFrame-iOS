import SwiftUI

class CollectViewModel: ObservableObject {
    @Published var collections: [Collection] = []
    @Published var userName: String = ""

    init() {
        // Use dummy user profile data
        let user = DummyData.user
        self.collections = user.collections
        self.userName = user.name
        // Normally, you'd load the user's collections from a database or backend here.
    }

    // MARK: - CRUD Operations for Collections

    func addCollection(title: String) {
        let newCollection = Collection(title: title, passages: []) // New collections start empty
        collections.append(newCollection)
    }

    func updateCollection(_ collectionToUpdate: Collection, title: String) {
        if let index = collections.firstIndex(where: { $0.id == collectionToUpdate.id }) {
            collections[index].title = title
            // If passages could also be updated, handle that here too
        }
    }

    func deleteCollection(_ collectionToDelete: Collection) {
        collections.removeAll { $0.id == collectionToDelete.id }
    }
}