//
//  CardPager.swift
//

import SwiftUI
import CoreMotion

/// Horizontal swipe-through of personal code statements.
/// Long-press flips to reveal an optional “why this matters”.
struct CardPager: View {
    let statements: [String]
    var onCompleted: () -> Void
    
    @State private var current = 0
    @State private var flipped = false
    @StateObject private var motion = ParallaxManager()
    
    var body: some View {
        ZStack {
            // Ambient affirmation ribbon
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.25), .blue.opacity(0.25)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .blendMode(.screen)
            .scaleEffect(1.8)
            .offset(y: -250)
            .blur(radius: 160)
            
            TabView(selection: $current) {
                ForEach(statements.indices, id: \.self) { index in
                    PersonalCodeCard(
                        text: statements[index],
                        flipped: index == current ? $flipped : .constant(false)
                    )
                    .modifier(
                        ParallaxModifier(
                            xTilt: motion.xTilt,
                            yTilt: motion.yTilt
                        )
                    )
                    .padding(.horizontal, 20)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: current) { newVal in
                flipped = false
                // Check if it's the last card. If statements is empty, count is 0, indices is empty.
                // So newVal (which is an index) should be compared to statements.count - 1.
                // Ensure statements is not empty before accessing statements.count - 1.
                if !statements.isEmpty && newVal == statements.count - 1 {
                    triggerCompletion(after: 0.4)
                } else if statements.isEmpty { // Handle empty case, complete immediately
                    triggerCompletion(after: 0.0)
                }
            }
        }
    }
    
    private func triggerCompletion(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { onCompleted() }
    }
}
