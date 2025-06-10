import SwiftUI
import Combine

class ExploreViewModel: ObservableObject {
    @Published var passages: [Passage] = []
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Load dummy passages (simulate async data fetch)
        Just(DummyData.passages)
            .delay(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] loaded in
                self?.passages = loaded
            }
            .store(in: &cancellables)
        // In a real app, this is where you'd fetch data from Firebase or an API.
    }
}