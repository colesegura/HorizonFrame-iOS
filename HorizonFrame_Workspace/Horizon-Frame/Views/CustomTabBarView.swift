import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: AppTab
    @State private var isExpanded: Bool = false
    
    @Namespace private var tabBarNamespace

    let collapsedFrameWidth: CGFloat = 100 
    let expandedFramePadding: CGFloat = 20 
    let itemSpacing: CGFloat = 10
    let frameCornerSize: CGFloat = 12 // Slightly smaller for a tighter look
    let frameLineWidth: CGFloat = 2
    let animationDuration: Double = 0.4 // A bit more pronounced animation

    var body: some View {
        HStack(spacing: isExpanded ? itemSpacing : 0) {
            ForEach(AppTab.allCases) { tab in
                if isExpanded || tab == selectedTab {
                    TabBarItem(
                        tab: tab,
                        isSelected: selectedTab == tab,
                        isExpanded: isExpanded,
                        namespace: tabBarNamespace,
                        frameCornerSize: frameCornerSize,
                        frameLineWidth: frameLineWidth,
                        animationDuration: animationDuration
                    )
                    .onTapGesture {
                        handleTap(on: tab)
                    }
                }
            }
        }
        .padding(.horizontal, isExpanded ? expandedFramePadding : (UIScreen.main.bounds.width - collapsedFrameWidth) / 2 ) // Center collapsed view
        .frame(width: isExpanded ? nil : collapsedFrameWidth) // Define width for collapsed state
        .frame(height: 60)
        // Removed opaque Capsule background to allow global gradient to show through
        // .background(
        //     Capsule()
        //         .fill(Color.black.opacity(isExpanded ? 0.6 : 0.3))
        //         .animation(.easeInOut(duration: animationDuration), value: isExpanded)
        // )
        .padding(.bottom, 8) // This padding is for spacing below the tab items themselves // Standard bottom padding, adjust if needed with safe area
    }

    private func handleTap(on tab: AppTab) {
        if isExpanded {
            if selectedTab != tab {
                withAnimation(.spring(response: animationDuration, dampingFraction: 0.65)) {
                    selectedTab = tab
                }
            }
            // Always collapse after a selection in expanded mode
            withAnimation(.spring(response: animationDuration * 0.9, dampingFraction: 0.75)) {
                isExpanded = false
            }
        } else {
            // If collapsed, tapping the selected tab expands it.
            // Tapping a (theoretically non-visible) different tab would also expand and select.
            withAnimation(.spring(response: animationDuration, dampingFraction: 0.75)) {
                isExpanded = true
                if selectedTab != tab { // Should only happen if logic changes to show other tabs when collapsed
                     selectedTab = tab
                }
            }
        }
    }
}

struct TabBarItem: View {
    let tab: AppTab
    let isSelected: Bool
    let isExpanded: Bool
    let namespace: Namespace.ID
    let frameCornerSize: CGFloat
    let frameLineWidth: CGFloat
    let animationDuration: Double

    var body: some View {
        // VStack(spacing: 2) { // Original VStack
            // Image(systemName: tab.iconName) // ICON REMOVED
            //     .font(.system(size: isExpanded ? 20 : (isSelected ? 22 : 1)))
            //     .opacity(isExpanded ? 1 : (isSelected ? 1: 0))
            //     .foregroundColor(isSelected ? .white : Color.gray.opacity(0.8))
            
            // Show text if expanded, or if selected & collapsed (which is always the case for visible collapsed items)
            // if isExpanded || (isSelected && !isExpanded) { 
                 Text(tab.title)
                    .font(isExpanded ? .callout : (isSelected ? .body.weight(.medium) : .callout) ) // Adjusted fonts for text-only
                    .lineLimit(1)
                    .foregroundColor(isSelected ? .white : Color.gray.opacity(0.9))
                    .padding(.vertical, isExpanded ? 2 : 0) // Add some vertical padding when expanded
            // }
        // }
        .padding(.horizontal, isExpanded ? 8 : (isSelected ? 10 : 0) )
        .padding(.vertical, isExpanded ? 5 : (isSelected ? 8 : 0))
        .frame(minWidth: isExpanded ? 65 : (isSelected ? 80 : 0), minHeight: isExpanded ? 30 : 40) // Adjusted minWidth and minHeight for text
        .contentShape(Rectangle())
        .modifier(FrameAroundModifier(
            showFrame: isSelected, 
            namespace: namespace,
            id: "TabBarFrame", 
            frameCornerSize: frameCornerSize,
            frameLineWidth: frameLineWidth
         ))
         // Smooth transition for items appearing/disappearing
        .transition(.asymmetric(insertion: .opacity.combined(with: .scale(scale: 0.8)), removal: .opacity.combined(with: .scale(scale: 0.8))))
        .animation(.spring(response: animationDuration, dampingFraction: 0.7), value: isSelected)
        .animation(.spring(response: animationDuration, dampingFraction: 0.7), value: isExpanded)
    }
}

struct FrameAroundModifier: ViewModifier {
    let showFrame: Bool
    let namespace: Namespace.ID
    let id: String
    let frameCornerSize: CGFloat
    let frameLineWidth: CGFloat

    func body(content: Content) -> some View {
        if showFrame {
            content
                .padding(frameCornerSize / 2 + frameLineWidth / 2) // Padding for the frame itself
                .background(
                    Rectangle() // The element that the matched geometry effect targets
                        .fill(Color.clear) // Must be clear, frame is drawn by overlay
                        .overlay(
                            GeometryReader { geometry in
                                let w = geometry.size.width
                                let h = geometry.size.height
                                FrameCornerView(size: frameCornerSize, lineWidth: frameLineWidth, color: .white).position(x: frameCornerSize / 2, y: cornerSize / 2)
                                FrameCornerView(size: frameCornerSize, lineWidth: frameLineWidth, color: .white).rotationEffect(.degrees(90)).position(x: w - cornerSize / 2, y: cornerSize / 2)
                                FrameCornerView(size: frameCornerSize, lineWidth: frameLineWidth, color: .white).rotationEffect(.degrees(-90)).position(x: cornerSize / 2, y: h - cornerSize / 2)
                                FrameCornerView(size: frameCornerSize, lineWidth: frameLineWidth, color: .white).rotationEffect(.degrees(180)).position(x: w - cornerSize / 2, y: h - cornerSize / 2)
                            }
                        )
                        .matchedGeometryEffect(id: id, in: namespace, properties: .frame, anchor: .center, isSource: true)
                )
        } else {
            content
        }
    }
    // Helper to access cornerSize from FrameCornerView, not strictly needed here if we pass it
    private var cornerSize: CGFloat { frameCornerSize }
}


#if DEBUG
struct CustomTabBarView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State var currentTab: AppTab = .align
        var body: some View {
            ZStack {
                AnimatedGradientBackground().ignoresSafeArea()
                VStack {
                    Spacer()
                    // Example of how content might switch
                    Group {
                        switch currentTab {
                            case .align: Text("Align Content View").foregroundColor(.white).font(.largeTitle)
                            case .collect: Text("Collect Content View").foregroundColor(.white).font(.largeTitle)
                            case .explore: Text("Explore Content View").foregroundColor(.white).font(.largeTitle)
                            case .settings: Text("Settings Content View").foregroundColor(.white).font(.largeTitle)
                        }
                    }.frame(maxHeight: .infinity)
                    
                    CustomTabBarView(selectedTab: $currentTab)
                }
            }
        }
    }
    static var previews: some View {
        PreviewWrapper()
    }
}
#endif
