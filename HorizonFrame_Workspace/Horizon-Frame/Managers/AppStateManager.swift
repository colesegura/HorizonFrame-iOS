import Foundation
import Combine

// A simple state manager to handle global app state, like showing the onboarding flow.
class AppStateManager: ObservableObject {
    @Published var showOnboarding: Bool = false
}
