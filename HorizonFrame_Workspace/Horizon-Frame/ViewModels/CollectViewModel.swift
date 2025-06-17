import SwiftUI

class CollectViewModel: ObservableObject {
    @Published var passages: [Passage] = []

    // Computed properties to filter passages for the view
    var activePassages: [Passage] {
        passages.filter { $0.isActive }
    }

    var addedPassages: [Passage] {
        passages.filter { !$0.isActive }
    }

    init() {
        // Load dummy passages. In a real app, this would come from a database.
        self.passages = DummyData.passages
    }

    // MARK: - CRUD Operations for Passages

    func addPassage(title: String, content: String, author: String?, category: String, tags: [String]?) {
        let newPassage = Passage(
            title: title,
            content: content,
            author: author,
            category: category,
            tags: tags,
            isActive: false // New passages start in the 'Added' section
        )
        passages.append(newPassage)
    }

    func deletePassage(at offsets: IndexSet, from passageList: [Passage]) {
        // Find the IDs of the passages to delete from the filtered list
        let idsToDelete = offsets.map { passageList[$0].id }
        // Remove all passages with those IDs from the main source array
        passages.removeAll { idsToDelete.contains($0.id) }
    }

    func toggleIsActive(for passage: Passage) {
        if let index = passages.firstIndex(where: { $0.id == passage.id }) {
            passages[index].isActive.toggle()
        }
    }
}