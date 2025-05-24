import SwiftUI

public struct CollectView: View {
    @EnvironmentObject private var data: AppData
    @State private var newInsight = ""
    @State private var hasOnboarded = UserDefaults.standard.bool(forKey: "collectOnboarded")
    @State private var newPersonalCodeStatementCollectView: String = ""

    public var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Personal code editable
                    Text("Personal Code")
                        .font(.title2).bold().foregroundColor(.white)
                    
                    // Display Personal Code items like in AlignView
                    ForEach(data.personalCode, id: \.self) { statement in
                        Text(statement)
                            .font(.title2)
                            .foregroundColor(Color.white.opacity(0.8)) // Consistent with AlignView non-focused items
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2) // Adjust padding as needed for spacing
                    }

                    // Add new Personal Code statement - styled like AlignView but darker
                    HStack {
                        TextField("Add new personal code...", text: $newPersonalCodeStatementCollectView, axis: .vertical)
                            .textFieldStyle(.plain)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                            .background(Color.white.opacity(0.05)) // Darker than AlignView's 0.1
                            .cornerRadius(8)
                            .lineLimit(1...3)
                        
                        Button {
                            let trimmedStatement = newPersonalCodeStatementCollectView.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !trimmedStatement.isEmpty {
                                data.personalCode.append(trimmedStatement)
                                newPersonalCodeStatementCollectView = "" // Clear the field
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(newPersonalCodeStatementCollectView.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray.opacity(0.5) : .white)
                                .imageScale(.large)
                        }
                        .disabled(newPersonalCodeStatementCollectView.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(.top, 5) // Add some space above the add field

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
