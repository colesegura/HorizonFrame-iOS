import SwiftUI
import UniformTypeIdentifiers

public struct CollectView: View {
    @EnvironmentObject private var data: AppData
    @State private var newInsight = ""
    @State private var hasOnboarded = UserDefaults.standard.bool(forKey: "collectOnboarded")
    @State private var newPersonalCodeStatementCollectView: String = ""
    @State private var showingFeedback = false
    @State private var feedbackMessage = ""
    
    private func showFeedback(_ message: String) {
        feedbackMessage = message
        showingFeedback = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showingFeedback = false
        }
    }
    
    private func submitInsight() {
        let trimmedInsight = newInsight.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInsight.isEmpty else { return }
        
        data.insights.insert(Insight(text: trimmedInsight), at: 0)
        newInsight = ""
        showFeedback("Insight added")
    }

    public var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Personal code editable
                    Text("Personal Code")
                        .font(.title2).bold().foregroundColor(.white)
                    
                    // Display Personal Code items like in AlignView
                    ForEach(data.personalCode.indices, id: \.self) { index in
                        let statement = data.personalCode[index]
                        HStack {
                            Text(statement)
                                .font(.title2)
                                .foregroundColor(Color.white.opacity(0.8))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 2)
                            
                            Button(action: {
                                data.personalCode.remove(at: index)
                                showFeedback("Personal code removed")
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red.opacity(0.8))
                            }
                        }
                        .padding(.horizontal)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(8)
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
                            .onSubmit {
                                submitInsight()
                            }
                        Button("Deposit") {
                            submitInsight()
                        }
                        .tint(.white)
                        .buttonStyle(.borderedProminent)
                        .disabled(newInsight.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }

                    ForEach(data.insights) { insight in
                        HStack {
                            Text("“\(insight.text)”")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button(action: {
                                if let index = data.insights.firstIndex(where: { $0.id == insight.id }) {
                                    data.insights.remove(at: index)
                                    showFeedback("Insight removed")
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red.opacity(0.8))
                                    .padding(.trailing)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black)
                                .stroke(Color.white.opacity(0.3))
                        )
                        .foregroundColor(.white)
                    }
                }
                .padding()
            }
            if !hasOnboarded { 
                OnboardingOverlay(text:
                    """
                    This is where you collect insights.\n\nAdd anything you want to remember. HorizonFrame will reflect them back to you during the day.
                    """,
                    cta: "Get Started") {
                        hasOnboarded = true
                        UserDefaults.standard.set(true, forKey: "collectOnboarded")
                    }
            }
            
            if showingFeedback {
                VStack {
                    Spacer()
                    Text(feedbackMessage)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(10)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: showingFeedback)
                }
                .padding(.bottom, 20)
            }
        }
    }
}
