import SwiftUI

struct KineticFrameView: View {
    var frameSize: CGFloat
    var cornerSize: CGFloat
    var lineWidth: CGFloat
    var color: Color

    // Animation properties
    @State var offset: CGSize = .zero
    @State var scale: CGFloat = 1.0
    @State var opacity: Double = 1.0

    var body: some View {
        ZStack {
            // Top-Left
            FrameCornerView(size: cornerSize, lineWidth: lineWidth, color: color)
                .rotationEffect(.degrees(0))
                .position(x: cornerSize / 2, y: cornerSize / 2)

            // Top-Right
            FrameCornerView(size: cornerSize, lineWidth: lineWidth, color: color)
                .rotationEffect(.degrees(90))
                .position(x: frameSize - cornerSize / 2, y: cornerSize / 2)

            // Bottom-Left
            FrameCornerView(size: cornerSize, lineWidth: lineWidth, color: color)
                .rotationEffect(.degrees(-90))
                .position(x: cornerSize / 2, y: frameSize - cornerSize / 2)

            // Bottom-Right
            FrameCornerView(size: cornerSize, lineWidth: lineWidth, color: color)
                .rotationEffect(.degrees(180))
                .position(x: frameSize - cornerSize / 2, y: frameSize - cornerSize / 2)
        }
        .frame(width: frameSize, height: frameSize)
        .scaleEffect(scale)
        .offset(offset)
        .opacity(opacity)
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        KineticFrameView(frameSize: 200, cornerSize: 50, lineWidth: 5, color: .white)
    }
}
