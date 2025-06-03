import SwiftUI

/// Card with long-press flip, showing personal code statements.
struct PersonalCodeCard: View {
    var text: String
    @Binding var flipped: Bool
    @GestureState private var pressed = false
    
    var body: some View {
        ZStack {
            // Card shell
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.thinMaterial) // Use system material
                .shadow(radius: 5) // Standard shadow
            
            // Front / back faces
            Group {
                if flipped {
                    Text("✨ Add context in CollectView ✨")
                        .font(.footnote.weight(.semibold))
                } else {
                    Text(text)
                        .font(.title3.weight(.regular))
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
