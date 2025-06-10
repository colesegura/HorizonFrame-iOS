import SwiftUI

struct AlignmentCompleteView: View {
    var onDismiss: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black.ignoresSafeArea()

            // Main Content
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the content is centered and provides a full-screen context for the ZStack alignment

            // Circular Checkmark Button
            Button(action: {
                onDismiss()
            }) {
                Image(systemName: "checkmark")
                    .font(.title.weight(.bold))
                    .foregroundColor(.black)
            }
            .frame(width: 64, height: 64)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
            .padding()
        }
    }
}
