import SwiftUI
import UniformTypeIdentifiers

public struct CollectView: View {
    // TODO: Consider if onAppear is needed to reset focus or keyboard state for TextFields
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
            TronGridBackground().ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Personal code editable
                    Text("Personal Code")
                        .font(.title2).bold().foregroundColor(.cyan)
                    
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
                        .padding(.vertical, 8) // Added vertical padding for consistency
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.cyan, lineWidth: 1)
                                )
                        )
                    }
                    .animation(.default, value: data.personalCode) // Applied to ForEach

                    // Add new Personal Code statement
                    VStack(alignment: .leading, spacing: 8) { // Changed to VStack for label and field
                        Text("Craft New Code Statement")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.cyan.opacity(0.8))
                        TextField("Type your new personal code here...", text: $newPersonalCodeStatementCollectView, axis: .vertical)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .lineLimit(1...5) // Increased line limit
                            .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.black.opacity(0.5))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.cyan, lineWidth: 1)
                                    )
                            )
                    }
                    Button {
                            let trimmedStatement = newPersonalCodeStatementCollectView.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !trimmedStatement.isEmpty {
                                data.personalCode.append(trimmedStatement)
                                newPersonalCodeStatementCollectView = "" // Clear the field
                            }
                        } label: {
                            Label("Deposit Code", systemImage: "arrow.down.to.line.compact")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.cyan.opacity(newPersonalCodeStatementCollectView.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.1 : 0.25))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.cyan, lineWidth: 1.5)
                                        )
                                )
                        }
                        .disabled(newPersonalCodeStatementCollectView.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .padding(.top, 10) // Add some space above the add field

                    // Insight collection
                    Text("Insight Collection")
                        .font(.title2).bold().foregroundColor(.cyan)
                    VStack(alignment: .leading, spacing: 8) { // Changed to VStack for label and field
                        Text("Capture New Insight")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.cyan.opacity(0.8))
                        TextField("Type your new insight here...", text: $newInsight, axis: .vertical)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .lineLimit(1...5) // Increased line limit
                            .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.black.opacity(0.5))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.cyan, lineWidth: 1)
                                    )
                            )
                            .submitLabel(.done)
                            .onSubmit {
                                submitInsight()
                            }
                    }
                    Button(action: {
                            submitInsight()
                        }) {
                            Label("Deposit Insight", systemImage: "arrow.down.to.line.compact")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.cyan.opacity(newInsight.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.1 : 0.25))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.cyan, lineWidth: 1.5)
                                        )
                                )
                        }
                        .disabled(newInsight.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .padding(.top, 10)

                    ForEach(data.insights) { insight in
                        HStack {
                            Text(insight.text)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white) // Ensure text is visible
                            
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
                        .padding(.horizontal)
                        .padding(.vertical, 8) // Added vertical padding for consistency
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.cyan, lineWidth: 1)
                                )
                        )
                    }
                    .animation(.default, value: data.insights) // Applied to ForEach
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
        .preferredColorScheme(.dark)
    }
}
