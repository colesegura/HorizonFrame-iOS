import SwiftUI

struct AlignmentCompleteView: View {
    var onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 28) {
                Image(systemName: "checkmark.seal")
                    .resizable()
                    .frame(width: 96, height: 96)
                    .foregroundColor(.green)

                Text("Great job!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                // Placeholder streak visualization
                Text("Current streak: 3 days 🔥")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))

                Button("Done") {
                    onDismiss()
                }
                .padding(.horizontal, 48)
                .padding(.vertical, 12)
                .background(Color.white, in: Capsule())
            }
        }
    }
}
