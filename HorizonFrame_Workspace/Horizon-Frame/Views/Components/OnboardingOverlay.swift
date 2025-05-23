import SwiftUI

public struct OnboardingOverlay: View {
    let text: String
    let cta: String
    let dismiss: () -> Void

    public var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            VStack(spacing: 24) {
                Text(text).multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                Button(cta, action: dismiss)
                    .padding(.horizontal, 32).padding(.vertical, 12)
                    .background(Capsule().fill(Color.white))
                    .foregroundColor(.black)
            }
            .padding()
        }
        .transition(.opacity)
    }
}
