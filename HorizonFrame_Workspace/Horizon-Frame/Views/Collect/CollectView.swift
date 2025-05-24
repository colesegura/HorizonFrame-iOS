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
                        .tint(.white) // Change button color to white
                        .buttonStyle(.borderedProminent) // Keep prominent style, tint handles color
                    }

                    ForEach(data.insights) { insight in
                        Text("“\(insight.text)”")
                            .padding().frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.black) // Ensure black background
                                    .stroke(Color.white.opacity(0.3)) // Keep the border
                            )
                            .foregroundColor(.white) // Ensure text is visible
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
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    .background(Color.clear) // Make background transparent
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1) // Add a subtle border
                    )
                    .foregroundColor(.white)
            }
            HStack {
                TextField(placeholder, text: $newLine)
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    .background(Color.clear) // Make background transparent
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1) // Add a subtle border
                    )
                    .foregroundColor(.white)
                Button("+") {
                    guard newLine.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else { return }
                    items.append(newLine); newLine = ""
                }
            }
        }
    }
}
