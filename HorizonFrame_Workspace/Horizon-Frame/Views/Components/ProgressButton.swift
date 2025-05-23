import SwiftUI

public struct ProgressButton: View {
    let progress: Double    // 0…1
    let onComplete: () -> Void

    public var body: some View {
        Button(action: { if progress >= 1 { onComplete() } }) {
            ZStack(alignment: .leading) {
                Capsule().fill(Color.white.opacity(0.2))
                GeometryReader { geo in
                    Capsule()
                        .fill(Color.white)
                        .frame(width: geo.size.width * progress)
                        .animation(.easeInOut, value: progress)
                }
                Text(progress >= 1 ? "Complete Alignment" :
                        "Complete Alignment").foregroundColor(.black)
                    .font(.body).bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(height: 44)
        }
        .disabled(progress < 1)
    }
}
