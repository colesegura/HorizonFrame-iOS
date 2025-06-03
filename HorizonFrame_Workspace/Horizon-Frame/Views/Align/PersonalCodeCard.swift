//
//  PersonalCodeCard.swift
//

import SwiftUI

/// Single card with 3D flip on long-press.
struct PersonalCodeCard: View {
    var text: String
    @Binding var flipped: Bool
    
    @GestureState private var isPressed = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white.opacity(0.05))
                .shadow(color: .white.opacity(0.12), radius: 8, y: 4)
            
            if flipped {
                // Back side placeholder
                VStack(spacing: 12) {
                    Text("Why this matters")
                        .font(.subheadline.weight(.semibold))
                        .opacity(0.7)
                    Text("← Add a note in CollectView")
                        .font(.footnote)
                        .opacity(0.6)
                }
                .multilineTextAlignment(.center)
                .padding()
                .transition(.opacity)
            } else {
                Text(text)
                    .font(.title3.weight(.regular))
                    .multilineTextAlignment(.center)
                    .padding(24)
                    .transition(.opacity)
            }
        }
        .frame(height: 260)
        .rotation3DEffect(
            .degrees(flipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: flipped)
        .gesture(
            LongPressGesture(minimumDuration: 0.4)
                .updating($isPressed) { _, s, _ in s = true }
                .onEnded { _ in flipped.toggle() }
        )
        .scaleEffect(isPressed ? 0.97 : 1)
    }
}
