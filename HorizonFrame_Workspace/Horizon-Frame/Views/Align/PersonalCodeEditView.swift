import SwiftUI

struct PersonalCodeEditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var data: AppData

    // Temporary state to hold editable lines. In a real scenario, you'd likely work with a copy
    // of the data.personalCode or bind directly if AppData handles undo/temporary states.
    @State private var editablePersonalCode: [String]

    init(personalCode: [String]) {
        _editablePersonalCode = State(initialValue: personalCode)
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($editablePersonalCode, id: \.self, editActions: .all) { $line in
                        TextEditor(text: $line)
                            .frame(minHeight: 30) // Adjust as needed
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }

                Button("Add New Line") {
                    editablePersonalCode.append("New line") // Add a default new line
                }
                .padding()
            }
            .navigationTitle("Edit Personal Code")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Save changes back to AppData
                        data.personalCode = editablePersonalCode
                        dismiss()
                    }
                }
            }
            .environment(\.editMode, .constant(.active)) // Keep list in edit mode
        }
        .preferredColorScheme(.dark) // Ensure sheet also respects dark mode
    }

    private func deleteItems(at offsets: IndexSet) {
        editablePersonalCode.remove(atOffsets: offsets)
    }

    private func moveItems(from source: IndexSet, to destination: Int) {
        editablePersonalCode.move(fromOffsets: source, toOffset: destination)
    }
}

struct PersonalCodeEditView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock AppData for previewing
        let mockData = AppData()
        mockData.personalCode = ["First line for preview", "Second line for preview"]
        
        return PersonalCodeEditView(personalCode: mockData.personalCode)
            .environmentObject(mockData)
    }
}
