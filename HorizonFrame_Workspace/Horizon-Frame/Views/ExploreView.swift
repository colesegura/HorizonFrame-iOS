import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var viewModel: ExploreViewModel
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "All"
    @State private var isSearchActive: Bool = false
    @State private var passageToShare: Passage? = nil
    @State private var renderedShareImage: UIImage? = nil
    @State private var showShareSheet: Bool = false

    // Dynamically get all unique categories from passages, plus "All"
    private var allCategories: [String] {
        ["All"] + Array(Set(viewModel.passages.map { $0.category })).sorted()
    }

    // Filter passages based on search text and selected category
    private var filteredPassages: [Passage] {
        let categoryFiltered = viewModel.passages.filter {
            selectedCategory == "All" || $0.category == selectedCategory
        }

        if searchText.isEmpty {
            return categoryFiltered
        } else {
            return categoryFiltered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText) ||
                ($0.author ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Conditional Search Bar
                    if isSearchActive {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search passages, authors, keywords...", text: $searchText)
                                .foregroundColor(.primary)
                                .autocorrectionDisabled(true)
                            if !searchText.isEmpty {
                                Button {
                                    searchText = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.15))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .transition(.asymmetric(insertion: .move(edge: .top).combined(with: .opacity), removal: .move(edge: .top).combined(with: .opacity)))
                    }

                    // Category Filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(allCategories, id: \.self) { category in
                                Button {
                                    selectedCategory = category
                                } label: {
                                    Text(category)
                                        .font(.subheadline)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(selectedCategory == category ? Color.accentColor : Color.gray.opacity(0.3))
                                        .foregroundColor(selectedCategory == category ? .white : .primary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Passages List
                    LazyVStack(spacing: 20) {
                        ForEach(filteredPassages) { passage in
                            NavigationLink {
                                PassageDetailView(passage: passage)
                            } label: {
                                PassageItemView(passage: passage) {
                                    // Share action
                                    self.passageToShare = passage
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom) // Add some padding at the bottom of the scroll content
                }
            }
            .background(Color.clear) // Ensure the ScrollView's own background is transparent for global gradient
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            isSearchActive.toggle()
                        }
                        if !isSearchActive {
                            searchText = "" // Clear search text when hiding
                        }
                    } label: {
                        Image(systemName: isSearchActive ? "xmark.circle" : "magnifyingglass")
                            .foregroundColor(.primary)
                    }
                }
            }
            .onChange(of: passageToShare) { newPassageToShare in
                guard let passage = newPassageToShare else { return }
                Task {
                    // Ensure ShareCardRenderer is called on MainActor if it does UI work internally
                    // or if ImageRenderer needs it, which it does.
                    await MainActor.run {
                        self.renderedShareImage = ShareCardRenderer().renderPassageCard(for: passage)
                        if self.renderedShareImage != nil {
                            self.showShareSheet = true
                        }
                    }
                }
            }
            .sheet(isPresented: $showShareSheet) {
                if let image = renderedShareImage {
                    ShareSheet(items: [image])
                } else {
                    // Optional: Show an error or a placeholder if image rendering failed
                    Text("Could not prepare content for sharing.")
                }
            }
        }
        .toolbarBackground(Color.clear, for: .navigationBar) // Keep it clear, though hidden should override
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar) // Force the nav bar background to be hidden
        // .navigationViewStyle(StackNavigationViewStyle()) // Not needed for NavigationStack
    }
}

// Custom view for displaying each passage item
struct PassageItemView: View {
    let passage: Passage
    var onShare: () -> Void // Closure for share action

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(passage.title)
                .font(.system(.headline, design: .serif))
                .foregroundColor(.primary)
                .lineLimit(2)

            Text(passage.content)
                .font(.system(.body, design: .serif).weight(.light))
                .foregroundColor(.primary.opacity(0.85))
                .lineSpacing(4)
                .lineLimit(4) // Show a snippet, full view in detail

            HStack {
                Text(passage.author ?? "Unknown Author")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text(passage.category)
                    .font(.caption2.bold())
                    .padding(.vertical, 3)
                    .padding(.horizontal, 8)
                    .background(Color.accentColor.opacity(0.2))
                    .foregroundColor(Color.accentColor)
                    .clipShape(Capsule())
                
                Button {
                    onShare()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .padding(.top, 4)
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#if DEBUG
struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy ExploreViewModel for preview
        let viewModel = ExploreViewModel()
        // Manually assign some dummy data if needed for immediate preview, 
        // or rely on the async load in init if that's quick enough.
        // viewModel.passages = DummyData.passages // Example of direct assignment

        return ExploreView()
            .environmentObject(viewModel)
            .preferredColorScheme(.dark)
            //.background(AnimatedGradientBackground().ignoresSafeArea()) // Background applied in MainAppView
    }
}

#endif