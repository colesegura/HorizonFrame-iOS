import SwiftUI

public struct ProgressView_HF: View {   // rename to avoid clash with system
    public var body: some View {
        VStack {
            Spacer()
            Text("Progress").font(.largeTitle).foregroundColor(.white)
            Text("Coming Soon").foregroundColor(.white.opacity(0.6))
            Spacer()
        }
    }
}
