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
                    LazyVStack(spacing: 0) { // Added LazyVStack, spacing can be adjusted
                        ForEach(data.personalCode, id: \.self) { statement in
                            Text(statement)
                                .font(.title2)
                                .foregroundColor(Color.white.opacity(0.8)) // Consistent color for now
                                // .onTapGesture { advance() } // Keep commented for swipe debugging
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 2) // Consistent spacing
                                // It's often better to apply swipeActions to the view inside ForEach directly
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                if let idxToDelete = data.personalCode.firstIndex(of: statement) { // Find index
                                    itemIndexToDelete = idxToDelete
                                    showingDeleteConfirmAlert = true
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            .tint(.gray) // Custom non-red color for delete

                            Button {
                                // Placeholder for Edit Action
                                print("Edit tapped for: \(statement)")
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue) // Example color for Edit
                        }
                        // Removed redundant closing brace for ForEach if it was here by mistake
                    } // End ForEach
                } // End LazyVStack
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
        .alert("Confirm Delete", isPresented: $showingDeleteConfirmAlert, presenting: itemIndexToDelete) { indexToDeleteInAlert in // Renamed to avoid conflict
            Button("Delete", role: .destructive) {
                if data.personalCode.indices.contains(indexToDeleteInAlert) { // Check if index is valid
                    let statementToDelete = data.personalCode[indexToDeleteInAlert]
                    data.personalCode.remove(at: indexToDeleteInAlert)
                    // Adjust current index if necessary - this logic might need to be removed or rethought
                    // if self.index >= data.personalCode.count && !data.personalCode.isEmpty {
                    //     self.index = data.personalCode.count - 1
                    // } else if data.personalCode.isEmpty {
                    //     self.index = 0 // Reset or handle empty state
                    // }
                    print("Deleted: \(statementToDelete)")
                } else {
                    print("Error: Index out of bounds or item already deleted.")
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: { indexToDeleteInAlertMessage in // Renamed to avoid conflict
            // Ensure index is valid before trying to access the element for the message
            if data.personalCode.indices.contains(indexToDeleteInAlertMessage) {
                Text("Are you sure you want to delete this statement: \"\(data.personalCode[indexToDeleteInAlertMessage])\"?")
            } else {
                Text("Are you sure you want to delete this statement?") // Fallback message
            }
        }
    }

    private func advance() {
        guard index < data.personalCode.count - 1 else { return }
        index += 1
    }
}
