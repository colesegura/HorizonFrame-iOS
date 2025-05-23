import SwiftUI

@MainActor
public final class AppData: ObservableObject {
    // MARK: - Persistence
    @AppStorage("personalCode") private var personalCodeRaw: Data = Data()
    @AppStorage("insights")     private var insightsRaw: Data = Data()

    // MARK: - Published state
    @Published public var personalCode: [String] {
        didSet { savePersonalCode() }
    }
    @Published public var insights: [Insight] {
        didSet { saveInsights(); NotificationService.schedule(insights: insights) }
    }

    public init() {
        // Fetch from UserDefaults directly to avoid using 'self.property' before full initialization.
        let pCodeData = UserDefaults.standard.data(forKey: "personalCode") ?? Data()
        let iData = UserDefaults.standard.data(forKey: "insights") ?? Data()

        let decodedPersonalCode = (try? JSONDecoder().decode([String].self, from: pCodeData)) ??
                                   ["I am grateful for this life and its experiences.",
                                    "I am committed to living as my true self.",
                                    "I am open to learning from my experiences."]
        let decodedInsights = (try? JSONDecoder().decode([Insight].self, from: iData)) ?? []

        // Initialize @Published properties. didSet observers run after 'self' is fully initialized.
        self.personalCode = decodedPersonalCode
        self.insights = decodedInsights
    }

    private func savePersonalCode() {
        personalCodeRaw = (try? JSONEncoder().encode(personalCode)) ?? Data()
    }

    private func saveInsights() {
        insightsRaw = (try? JSONEncoder().encode(insights)) ?? Data()
    }
}
