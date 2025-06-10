import SwiftUI

/// A modifier that animates a view from a small frame into a full-screen
/// black overlay.  Use on the button label that triggers the alignment session.
struct ExpandingButtonModifier: ViewModifier {
    @State private var animate = false
    let onComplete: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            if animate {
                Color.black.ignoresSafeArea()
                    .transition(.identity)
                    .onAppear {
                        // Wait for the color expansion before calling onComplete
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            onComplete()
                        }
                    }
            }
            content
                .scaleEffect(animate ? 40 : 1)          // huge scale = fills screen
                .opacity(animate ? 0 : 1)
        }
        .animation(.easeInOut(duration: 0.35), value: animate)
        .onTapGesture { animate = true }
    }
}

extension View {
    func expandingButton(toFullScreen completion: @escaping () -> Void) -> some View {
        modifier(ExpandingButtonModifier(onComplete: completion))
    }
}
