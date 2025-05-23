import SwiftUI

public struct CollectView: View {
    @EnvironmentObject private var data: AppData
    @State private var newInsight = ""
    @State private var hasOnboarded = UserDefaults.standard.bool(forKey: "collectOnboarded")

    public var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Personal code editable
                    Text("Personal Code")
                        .font(.title2).bold().foregroundColor(.white)
                    EditableList(title: "Tap to iterate ›",
                                 items: $data.personalCode,
                                 placeholder: "Add new line")

                    // Insight collection
                    Text("Insight Collection")
                        .font(.title2).bold().foregroundColor(.white)
                    VStack(spacing: 12) {
                        TextField("Deposit your next insight…", text: $newInsight)
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.done)
                        Button("Deposit") {
                            guard newInsight.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else { return }
                            data.insights.insert(Insight(text: newInsight), at: 0)
                            newInsight = ""
                        }
                        .buttonStyle(.borderedProminent)
                    }

                    ForEach(data.insights) { insight in
                        Text("“\(insight.text)”")
                            .padding().frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.white.opacity(0.3)))
                    }
                }
                .padding()
            }
            if !hasOnboarded { OnboardingOverlay(text:
                """
                This is where you collect insights.\n\nAdd anything you want to remember. HorizonFrame will reflect them back to you during the day.
                """,
                cta: "Get Started") {
                    hasOnboarded = true
                    UserDefaults.standard.set(true, forKey: "collectOnboarded")
                }
            }
        }
    }
}

private struct EditableList: View {
    let title: String
    @Binding var items: [String]
    let placeholder: String
    @State private var newLine = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(items.indices, id: \.self) { idx in
                TextField("Line \(idx + 1)", text: $items[idx])
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                TextField(placeholder, text: $newLine)
                    .textFieldStyle(.roundedBorder)
                Button("+") {
                    guard newLine.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else { return }
                    items.append(newLine); newLine = ""
                }
            }
        }
    }
}
