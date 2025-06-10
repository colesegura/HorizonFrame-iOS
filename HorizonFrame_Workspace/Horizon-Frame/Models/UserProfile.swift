import Foundation
import Combine

class UserProfile: ObservableObject, Identifiable {
    let id: UUID = UUID()
    @Published var name: String
    @Published var collections: [Collection]
    // Add other user properties as needed (e.g. email, avatar, settings)

    init(name: String, collections: [Collection]) {
        self.name = name
        self.collections = collections
    }
}