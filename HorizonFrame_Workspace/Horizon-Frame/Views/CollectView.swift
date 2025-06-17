import SwiftUI

struct CollectView: View {
    @EnvironmentObject private var viewModel: CollectViewModel
    @EnvironmentObject private var storeManager: StoreManager
    @State private var showAddSheet = false
    @State private var showSubscriptionSheet = false
    @State private var showReferralShare = false
    @State private var showPremiumStatusSheet = false

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Active Section
                if !viewModel.activePassages.isEmpty {
                    SectionHeader(title: "Active")
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.activePassages) { passage in
                            NavigationLink(destination: PassageDetailView(passage: passage)) {
                                ZStack(alignment: .topTrailing) {
                                    PassageCardView(passage: passage)
                                    
                                    Button(action: { viewModel.toggleIsActive(for: passage) }) {
                                        Image(systemName: passage.isActive ? "star.fill" : "star")
                                            .font(.title3)
                                            .foregroundColor(passage.isActive ? .yellow : .white)
                                            .padding(6)
                                            .background(Color.black.opacity(0.6))
                                            .clipShape(Circle())
                                    }
                                    .buttonStyle(.plain) // Ensures the button action is localized and doesn't trigger the NavLink
                                    .padding(8)
                                }
                            }
                        }
                        .onDelete { offsets in
                            viewModel.deletePassage(at: offsets, from: viewModel.activePassages)
                        }
                    }
                    .padding(.horizontal)
                }

                // Added Section
                if !viewModel.addedPassages.isEmpty {
                    SectionHeader(title: "Added")
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.addedPassages) { passage in
                            NavigationLink(destination: PassageDetailView(passage: passage)) {
                                ZStack(alignment: .topTrailing) {
                                    PassageCardView(passage: passage)

                                    Button(action: { viewModel.toggleIsActive(for: passage) }) {
                                        Image(systemName: passage.isActive ? "star.fill" : "star")
                                            .font(.title3)
                                            .foregroundColor(passage.isActive ? .yellow : .white)
                                            .padding(6)
                                            .background(Color.black.opacity(0.6))
                                            .clipShape(Circle())
                                    }
                                    .buttonStyle(.plain) // Ensures the button action is localized and doesn't trigger the NavLink
                                    .padding(8)
                                }
                            }
                        }
                        .onDelete { offsets in
                            viewModel.deletePassage(at: offsets, from: viewModel.addedPassages)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .navigationTitle("Collection")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    if storeManager.isPremium {
                        showPremiumStatusSheet = true
                    } else {
                        showSubscriptionSheet = true
                    }
                } label: {
                    Image(systemName: storeManager.isPremium ? "crown.fill" : "crown")
                        .foregroundColor(.white)
                }

                Button(action: { showReferralShare = true }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                }

                Button(action: { showAddSheet = true }) {
                    Image(systemName: "plus")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddPassageView {
                
                viewModel.addPassage(title: $0, content: $1, author: $2, category: $3, tags: $4)
            }
        }
        .sheet(isPresented: $showSubscriptionSheet) {
            SubscriptionOptionsView()
        }
        .sheet(isPresented: $showReferralShare) {
            ReferralView()
        }
        .sheet(isPresented: $showPremiumStatusSheet) {
            PremiumStatusView()
        }
    }
}

// MARK: - Subviews

private struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2).bold()
            .foregroundColor(.white.opacity(0.9))
            .padding(.horizontal)
            .padding(.top, 20)
            .padding(.bottom, 10)
    }
}



private struct AddPassageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var author: String = ""
    @State private var category: String = "Bible"
    @State private var tags: String = ""

    let onSave: (String, String, String?, String, [String]?) -> Void
    let categories = ["Bible", "Philosophical", "Ancient Wisdom", "Poetry & Literature", "Scientific Insights", "Mindfulness & Meditation", "Art & Creativity", "Nature & Cosmos", "Human Experience"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Passage Details")) {
                    TextField("Title", text: $title)
                    TextField("Author (Optional)", text: $author)
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { Text($0) }
                    }
                }

                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(minHeight: 150)
                }

                Section(header: Text("Tags"), footer: Text("Separate tags with commas.")) {
                    TextField("e.g. faith, hope, love", text: $tags)
                }
            }
            .navigationTitle("Add New Passage")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let tagArray = tags.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
                        onSave(title, content, author.isEmpty ? nil : author, category, tagArray.isEmpty ? nil : tagArray)
                        dismiss()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
}