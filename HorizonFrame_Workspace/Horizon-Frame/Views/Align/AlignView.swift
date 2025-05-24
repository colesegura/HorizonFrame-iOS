import SwiftUI

public struct AlignView: View {
    @EnvironmentObject private var data: AppData
    @State private var index = 0
    @State private var hasOnboarded = UserDefaults.standard.bool(forKey: "alignOnboarded")
    @State private var newCodeStatement: String = ""
    @State private var showingDeleteConfirmAlert: Bool = false
    @State private var itemIndexToDelete: Int? = nil

    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(Date.now.formatted(date: .long, time: .omitted))
                        .font(.footnote).foregroundColor(.white.opacity(0.6))
                    Spacer() // Keep spacer to push date to the left
                }
                Spacer().frame(height: 20)
                HStack {
                    TextField("Craft a new intention...", text: $newCodeStatement, axis: .vertical)
                        .textFieldStyle(.plain)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .lineLimit(1...3) // Allow a few lines for the text field
                    
                    Button {
                        if !newCodeStatement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            data.personalCode.append(newCodeStatement.trimmingCharacters(in: .whitespacesAndNewlines))
                            newCodeStatement = "" // Clear the field
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(newCodeStatement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray.opacity(0.5) : .white)
                            .imageScale(.large)
                    }
                    .disabled(newCodeStatement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.bottom, 5) // Add a little space below the add field

                ScrollView {
                    ForEach(Array(data.personalCode.enumerated()), id: \.offset) { idx, line in
                    Text(line)
                        .font(.title2)
                        .fontWeight(idx == index ? .bold : .regular)
                        .foregroundColor(idx == index ? .white : Color.white.opacity(0.6))
                        // .onTapGesture { advance() } // Temporarily removed for swipe debugging
                        // .animation(.easeInOut, value: index) // Temporarily removed for swipe debugging
                        .frame(maxWidth: .infinity, alignment: .leading) // Ensure text takes full width
                        .padding(.vertical, 2) // Added for consistent spacing with CollectView
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                itemIndexToDelete = idx
                                showingDeleteConfirmAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            .tint(.gray) // Custom non-red color for delete

                            Button {
                                // Placeholder for Edit Action
                                print("Edit tapped for: \(data.personalCode[idx])")
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue) // Example color for Edit
                        }
                    }
                } // End ScrollView
                
                Spacer()
                ProgressButton(progress: Double(index + 1) / Double(data.personalCode.count)) {
                    index = 0     // reset
                }
            }
            .padding()
            if !hasOnboarded { OnboardingOverlay(text:
                """
                Welcome to HorizonFrame.\n\nHere you’ll craft a daily practice that aligns your intentions and vision with the life you want to live.
                """,
                cta: "Next") {
                    hasOnboarded = true
                    UserDefaults.standard.set(true, forKey: "alignOnboarded")
                }
            }
        }
        .onAppear { index = 0 }
        .alert("Confirm Delete", isPresented: $showingDeleteConfirmAlert, presenting: itemIndexToDelete) { indexToDelete in
            Button("Delete", role: .destructive) {
                data.personalCode.remove(at: indexToDelete)
                // Adjust current index if necessary
                if self.index >= data.personalCode.count && !data.personalCode.isEmpty {
                    self.index = data.personalCode.count - 1
                } else if data.personalCode.isEmpty {
                    self.index = 0 // Reset or handle empty state
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: { indexToDelete in
            Text("Are you sure you want to delete this statement: \"\(data.personalCode[indexToDelete])\"?")
        }
    }

    private func advance() {
        guard index < data.personalCode.count - 1 else { return }
        index += 1
    }
}
