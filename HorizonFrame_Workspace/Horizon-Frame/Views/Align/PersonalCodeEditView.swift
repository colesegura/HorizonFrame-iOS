import SwiftUI

/// Tron-grid makeover for editing personal code.
struct PersonalCodeEditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var data: AppData
    @State private var draft: [String]
    
    init(personalCode: [String]) {
        _draft = State(initialValue: personalCode)
    }
    
    var body: some View {
        ZStack {
            TronGridBackground()      // Same grid used elsewhere
            
            VStack {
                List {
                    ForEach($draft, id: \.self, editActions: .all) { $line in
                        TextEditor(text: $line)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
                            .frame(minHeight: 36)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.cyan, lineWidth: 1)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.black.opacity(0.5))
                                    )
                            )
                            .padding(.vertical, 6)
                    }
                    .onDelete { draft.remove(atOffsets: $0) }
                    .onMove   { draft.move(fromOffsets: $0, toOffset: $1) }
                }
                .scrollContentBackground(.hidden)
                
                Button {
                    draft.append("New line")
                } label: {
                    Label("Add New Line", systemImage: "plus")
                        .foregroundColor(.white)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.cyan.opacity(0.25))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.cyan, lineWidth: 1.5)
                                )
                        )
                }
                .padding(.top, 8)
            }
            .navigationTitle("Edit Personal Code")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        data.personalCode = draft
                        dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .environment(\.editMode, .constant(.active))
    }
}
