import SwiftUI

/// Tron-styled neon card with long-press flip.
struct PersonalCodeCard: View {
    var text: String
    @Binding var flipped: Bool
    @GestureState private var pressed = false
    
    var body: some View {
        ZStack {
            // Card shell
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(Color.cyan, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color.black.opacity(0.6))
                        .blur(radius: 6)
                )
                .shadow(color: .cyan.opacity(0.25), radius: 18)
            
            // Front / back faces
            Group {
                if flipped {
                    Text("✨ Add context in CollectView ✨")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.cyan)
                } else {
                    Text(text)
                        .font(.title3.weight(.regular))
                        .foregroundColor(.white)
                }
            }
            .multilineTextAlignment(.center)
            .padding(26)
            .transition(.opacity)
        }
        .frame(height: 260)
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (0,1,0))
        .scaleEffect(pressed ? 0.96 : 1)
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: flipped)
        .gesture(
            LongPressGesture(minimumDuration: 0.35)
                .updating($pressed) { _, s, _ in s = true }
                .onEnded { _ in flipped.toggle() }
        )
    }
}
