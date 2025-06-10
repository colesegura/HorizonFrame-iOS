import SwiftUI

struct CollectView: View {
    @EnvironmentObject var vm: CollectViewModel
    @State private var showAddSheet = false
    @State private var editingCollection: Collection? = nil

    var body: some View {
        List {
            ForEach(vm.collections, id: \.id) { collection in
                CollectionRowView(
                    collection: collection,
                    onTap: { self.editingCollection = collection },
                    onDelete: { self.vm.deleteCollection(collection) }
                )
            }
        }
        .scrollContentBackground(.hidden) // Make List background transparent
        .background(Color.clear) // Ensure the view itself is transparent
        .navigationTitle("Collections")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddCollectionView() {
                vm.addCollection(title: $0)
            }
        }
        .sheet(item: $editingCollection) { collection in
            EditCollectionView(collection: collection) {
                vm.updateCollection(collection, title: $0)
            }
        }
    }
}

// Row view for a single collection item
private struct CollectionRowView: View {
    let collection: Collection
    let onTap: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack {
            Text(collection.title)
                .font(.headline)
            Spacer()
            Text("\(collection.passages.count) passages")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle()) // Make whole row tappable
        .onTapGesture {
            onTap()
        }
        .swipeActions {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

// Sheet for adding a new collection
private struct AddCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    var onSave: (String) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Collection Title", text: $title)
            }
            .navigationTitle("New Collection")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
            }
        }
    }
}

// Sheet for editing an existing collection
private struct EditCollectionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String
    var onSave: (String) -> Void

    init(collection: Collection, onSave: @escaping (String) -> Void) {
        _title = State(initialValue: collection.title)
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Collection Title", text: $title)
            }
            .navigationTitle("Edit Collection")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
            }
        }
    }
}